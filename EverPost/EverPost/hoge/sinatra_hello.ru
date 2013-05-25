require 'rubygems'
gem 'sinatra', '=1.0'
require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end

run MyApp.new