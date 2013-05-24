#
#  evernote.rb
#  EverPost
#
#  Created by AirMyac on 5/25/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#
# encoding: utf-8
require "digest/md5"
require 'evernote_oauth'
require 'mimemagic'
require 'yaml'

def login(filename)
	# tokenの設定
	authToken = YAML.load_file(filename).fetch('authToken')
	# tokenのチェック
	if authToken == "your developer token"
		puts "Please fill in your developer token"
		puts "To get a developer token, visit https://sandbox.evernote.com/api/DeveloperToken.action"
		exit(1)
	end
	return authToken
end


def create_noteStore(authToken)
	# 環境の設定`
	evernoteHost = "sandbox.evernote.com"
	userStoreUrl = "https://#{evernoteHost}/edam/user"

	# 
	userStoreTransport = Thrift::HTTPClientTransport.new(userStoreUrl)
	userStoreProtocol = Thrift::BinaryProtocol.new(userStoreTransport)
	userStore = Evernote::EDAM::UserStore::UserStore::Client.new(userStoreProtocol)

	versionOK = userStore.checkVersion("Evernote EDAMTest (Ruby)",
					   Evernote::EDAM::UserStore::EDAM_VERSION_MAJOR,
					   Evernote::EDAM::UserStore::EDAM_VERSION_MINOR)
	# puts "Is my Evernote API version up to date?  #{versionOK}"
	# puts
	exit(1) unless versionOK

	# Create NoteStore
	noteStoreUrl = userStore.getNoteStoreUrl(authToken)

	noteStoreTransport = Thrift::HTTPClientTransport.new(noteStoreUrl)
	noteStoreProtocol = Thrift::BinaryProtocol.new(noteStoreTransport)
	noteStore = Evernote::EDAM::NoteStore::NoteStore::Client.new(noteStoreProtocol)

	return noteStore

end


# NoteBookの一覧の取得
def get_notebook_list(authToken, noteStore)
	notebooks = noteStore.listNotebooks(authToken)
	# notebooks.each do |notebook|
	#   puts "  * #{notebook.name}"
	# end
	return notebooks
end

# NoteBookの名称からGUIDを取得
def get_notebook_guid(name, authToken, noteStore)
	notebooks = get_notebook_list(authToken, noteStore)
	guid = nil
	notebooks.each do |notebook|
		if notebook.name == name
			guid = notebook.guid
		end
	end
	return guid
end

# Noteのオブジェクトを作成
def create_note(note_data)
	note = Evernote::EDAM::Type::Note.new
	note.title = note_data.fetch('title')
	note.notebookGuid = note_data.fetch('notebook')
	note.tagNames = note_data.fetch('tag')

	filenames = note_data.fetch('path')
	note.resources = []
	mime_types = []
	hashHexs = []
	filenames.each do |filename|
		mime_type = MimeMagic.by_path(filename).to_s
		base_name = File.basename(filename)
		image = File.open(filename, "rb") { |io| io.read }
		hashFunc = Digest::MD5.new

		data = Evernote::EDAM::Type::Data.new
		data.size = image.size
		data.bodyHash = hashFunc.digest(image)
		data.body = image

		resource = Evernote::EDAM::Type::Resource.new
		resource.mime = mime_type
		resource.data = data
		resource.attributes = Evernote::EDAM::Type::ResourceAttributes.new
		resource.attributes.fileName = base_name 
		hashHex = hashFunc.hexdigest(image)
		note.resources.push(resource)

		mime_types.push(mime_type)
		hashHexs.push(hashHex)
	end

	note.content  = create_content(filenames, mime_types, hashHexs)
	return note
end

# Post notebook to Evernote
def post(authToken, noteStore, note)
	createdNote = noteStore.createNote(authToken, note)
	puts "Successfully created a new note with GUID: #{createdNote.guid}"
end

## Create ENML
def create_content(filenames, mime_types, hashHexs)
content = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>This is MacRuby's Test!!<br/>
EOF

i = 0
while i < filenames.size
content += <<-EOF
<en-media type="#{mime_types[i]}" hash="#{hashHexs[i]}"/>
EOF
i += 1
end

content += <<-EOF
</en-note>
EOF

	return content 
end

