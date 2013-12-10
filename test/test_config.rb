PGP_ENV = ENV['RACK_ENV'] ||= 'test' unless defined?(PGP_ENV)
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PGP_ENV)
require ::File.join(::File.dirname(__FILE__), '../app/app.rb' )

class MiniTest::Unit::TestCase
  include Rack::Test::Methods
end
