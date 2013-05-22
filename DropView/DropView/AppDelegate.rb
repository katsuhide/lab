#
#  AppDelegate.rb
#  DropView
#
#  Created by AirMyac on 5/22/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#

class AppDelegate
    attr_accessor :window
    attr_accessor :button
    attr_accessor :textField
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
    end
    
    def button(sender)
        puts "hoge"
        textField.setStringValue("hoge")
    end
    
end

