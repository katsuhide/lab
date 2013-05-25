# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'evernote_oauth'
require 'haml'

use Rack::Session::Cookie,
  :key => "rack.session",
  :domain => "localhost",
  :path => "/",
  :expire_after => 3600,
  :secret => SecureRandom.hex(32)

get "/" do
  client = EvernoteOAuth::Client.new(
    :consumer_key => "katzlifehack",
    :consumer_secret => "9490d8896d0bb1a3",
    :sandbox => true
  )
  callback_url = "#{request.url}callback"
  request_token = client.request_token(:oauth_callback => callback_url)
  session[:request_token] = request_token

  @authorize_url = request_token.authorize_url
  haml :index
end

get "/callback" do
  request_token = session[:request_token]
  verifier = params[:oauth_verifier]
  access_token = request_token.get_access_token(oauth_verifier: verifier)
  @token = access_token.token

  haml :callback
end

puts "hoge"
url = "http://localhost:4567"
system "open #{url}"

__END__

@@ layout
!!!
%html(lang="ja")
  %head
    %meta(charset="UTF-8")
    %title #{@page_title}
  %body
    = yield

@@ index
- @page_title = "Authorize my app"
%p
  %a(href=@authorize_url)<Click to authorize my app

@@ callback
- @page_title = "Your token for Evernote access"
%p
  Your token is:
  %form
    %input(type="text" value=@token size=40)