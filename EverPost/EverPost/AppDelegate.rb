#
#  AppDelegate.rb
#  EverPost
#
#  Created by AirMyac on 5/21/13	.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#
# encoding: utf-8
require 'rubygems'
require "add_note"

class AppDelegate
    attr_accessor :window
    attr_accessor :textField
    attr_accessor :tagField
    attr_accessor :pathField
    attr_accessor :combo_box
    attr_accessor :path_field

    @@attached_files = []

    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
      @@attached_files.clear
  		@conffile = path_field.stringValue
	    refresh()
    end
   
   	def post_evernote(sender)
   		authToken = login(@conffile)
  		noteStore = create_noteStore(authToken)
   		data = Hash.new
   		data.store('title', textField.stringValue)
   		data.store('tag', tagField.stringValue.split(','))
  		data.store('notebook', get_notebook_guid(combo_box.stringValue, authToken, noteStore))
   		data.store('path', @@attached_files)
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
   		p @@attached_files
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

   	def AppDelegate.set_attached_files(files)
      @@attached_files = files
   	end

    def AppDelegate.clear_attached_files()
      @@attached_files.clear
    end

end

