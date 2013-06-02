# encoding: utf-8
require 'rubygems'
$LOAD_PATH.push(Dir::pwd) 

require "evernote"

def create_data()
	data = Hash.new
	data.store('title', "launch test")
	data.store('tag', ["test"])
	data.store('notebook', nil)
	filename = ["/Users/AirMyac/Desktop/fuga.txt", "/Users/AirMyac/Desktop/memo.pdf"]
	data.store('path', filename)

	return data
end

conffile = "evernote.yaml"
authToken = login(conffile)
noteStore = create_noteStore(authToken)
notebooks = get_notebook_list(authToken, noteStore)
# puts notebooks
# note = create_note(create_data())
note = create_simple_note(create_data())
# puts note
post(authToken, noteStore, note)