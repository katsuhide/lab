require 'rubygems'
gem 'sinatra', '=1.0'
require 'sinatra/base'
require 'haml'

class MyApp < Sinatra::Base
  get '/' do
    'Hello world!'
    haml :index

  end
end

run MyApp.new