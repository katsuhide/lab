require 'rubygems'
gem 'sinatra', '=1.0'
require 'sinatra/base'
require 'sinatra'
require 'evernote_oauth'

use Rack::Session::Cookie,
  :key => "rack.session",
  :domain => "localhost",
  :path => "/",
  :expire_after => 3600,
  :secret => SecureRandom.hex(32)

class MyApp < Sinatra::Base
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
    'Hello world!'
    "Authorize my app"

  end

end

run MyApp.new
