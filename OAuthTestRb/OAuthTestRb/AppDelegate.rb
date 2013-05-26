#
#  AppDelegate.rb
#  OAuthTestRb
#
#  Created by AirMyac on 5/26/13.
#  Copyright 2013 com.katzlifehack. All rights reserved.
#
# encoding: utf-8
require 'rubygems'
require 'digest/md5'
require 'evernote_oauth'

class AppDelegate
    attr_accessor :window
    attr_accessor :webView
    
    def applicationDidFinishLaunching(a_notification)
        # Insert code here to initialize your application
        client = EvernoteOAuth::Client.new(
                                           consumer_key: "katzlifehack",
                                           consumer_secret: "9490d8896d0bb1a3",
                                           sandbox: [true]
                                           )
        
        # request_token = client.request_token(:oauth_callback => 'YOUR CALLBACK URL')
        request_token = client.request_token(:oauth_callback => "callback_url")

        # url = "http://www.apple.com/"
        url = request_token.authorize_url
        nsurl = NSURL.URLWithString(url)
        nsurl_req = NSURLRequest.requestWithURL(nsurl)
        webView.mainFrame.loadRequest(nsurl_req)
    
    end
            
    
end

