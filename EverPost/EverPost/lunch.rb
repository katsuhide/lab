# encoding: utf-8
require 'rubygems'
$LOAD_PATH.push(Dir::pwd) 

require "add_note"

def create_data()
	data = Hash.new
	data.store('title', "textField.stringValue")
	data.store('tag', ["test"])
	data.store('notebook', "")
	filename = "/Users/AirMyac/Desktop/fuga.txt"
	data.store('path', filename)

	return data
end

authToken = login()
noteStore = create_noteStore(authToken)
notebooks = get_notebook_list(authToken, noteStore)
note = create_note(create_data())
post(authToken, noteStore, note)