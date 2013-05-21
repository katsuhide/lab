# encoding: utf-8
require 'rubygems'
$LOAD_PATH.push(Dir::pwd) 

require "add_note"

data = Hash.new
data.store('title', "textField.stringValue")
data.store('tag', ["test"])
data.store('notebook', "")
filename = "/Users/AirMyac/Desktop/fuga.txt"
data.store('path', filename)
post_note(data)

post_note(data)
		