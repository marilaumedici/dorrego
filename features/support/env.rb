ENV['RACK_ENV'] = 'test'
require 'simplecov'

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '../../'))
  add_filter '/specs/'
  add_filter '/features/'
end


require File.join(File.dirname(__FILE__), '..', '..', 'application.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = MyApplication

class MyApplicationWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  MyApplicationWorld.new
end
