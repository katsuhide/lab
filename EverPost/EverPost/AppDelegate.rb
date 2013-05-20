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
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def hello(sender)
        puts "hello world."
        str = "MacRubyTest2"
        post_note(str)
    end
    
end

