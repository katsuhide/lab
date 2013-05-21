# encoding: utf-8
require "digest/md5"
require 'evernote_oauth'
require 'mimemagic'


def login()
	# tokenの設定
	authToken = "S=s1:U=52d8f:E=144f9fd7003:C=13da24c4404:P=1cd:A=en-devtoken:V=2:H=103adc60d84f44dccc1455d8b7ca165d"
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
	puts "Is my Evernote API version up to date?  #{versionOK}"
	puts
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

	filename = note_data.fetch('path')
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
	note.resources = [ resource ]
	hashHex = hashFunc.hexdigest(image)

note.content = <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">
<en-note>This is MacRuby's Test!!<br/>
  <en-media type="#{mime_type}" hash="#{hashHex}"/>
</en-note>
EOF

	return note
end

# Post notebook to Evernote
def post(authToken, noteStore, note)
	createdNote = noteStore.createNote(authToken, note)
	puts "Successfully created a new note with GUID: #{createdNote.guid}"
end

