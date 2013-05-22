#
#  AppDelegate.rb
#  EverPost
#
#  Created by AirMyac on 5/21/13	.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#
# encoding: utf-8
require 'rubygems'
path = "/Users/AirMyac/github/lab/EverPost/EverPost"
$LOAD_PATH.push(Dir::pwd)	 
$LOAD_PATH.push(path) 

require "add_note"

class AppDelegate
    attr_accessor :window
    attr_accessor :textField
    attr_accessor :tagField
    attr_accessor :pathField
    attr_accessor :combo_box

    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
		@conffile = "/Users/AirMyac/github/lab/EverPost/EverPost/evernote.yaml"
	    refresh()
    end
   
   	def post_evernote(sender)
   		authToken = login(@conffile)
		noteStore = create_noteStore(authToken)
   		data = Hash.new
   		data.store('title', textField.stringValue)
   		data.store('tag', tagField.stringValue.split(','))
		data.store('notebook', get_notebook_guid(combo_box.stringValue, authToken, noteStore))
   		data.store('path', pathField.stringValue)
		note = create_note(data)
		post(authToken, noteStore, note)
   	end 
   
   	def test(sender)
   		textField.setStringValue("1234")
   	end 

   	def get(sender)
   		p @conffile
   		puts textField.stringValue
   		puts combo_box.stringValue
   		puts tagField.stringValue
   	end

   	# 画面の更新 
   	def refresh()
		authToken = login(@conffile)
		noteStore = create_noteStore(authToken)
		notebooks = get_notebook_list(authToken, noteStore)
	    notebooks.each do |notebook|
		    combo_box.addItemWithObjectValue(notebook.name)
	    end
	    combo_box.selectItemAtIndex(0)
   	end

end

