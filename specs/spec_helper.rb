ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'simplecov'

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '../'))
  add_filter '/specs/'
end

AWS.stub!
require_relative '../application.rb'

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.add_formatter('documentation')
end

