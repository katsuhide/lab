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
    attr_accessor :pathField

    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
   
   	def post_evernote(sender)
   		data = Hash.new
   		data.store('title', textField.stringValue)
   		data.store('tag', ["test"])
   		data.store('notebook', "")
   		data.store('path', pathField.stringValue)
   		post_note(data)
   	end 
   
   	def test(sender)
   		textField.setStringValue("1234")
   	end 

   	def get(sender)
   		puts textField.stringValue
   	end
end

