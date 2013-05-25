require 'rubygems'
require 'bundler/setup'
gem 'rack', '=1.2.1'
gem 'sinatra', '~> 1.0.0'
gem 'control_tower'
require 'sinatra'

get '/' do
  "hello, world"
end
