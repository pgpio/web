#!/usr/bin/env rackup
# encoding: utf-8

# Defines our constants
PGP_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(PGP_ENV)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PGP_ENV)
require ::File.join(::File.dirname(__FILE__), 'app/app.rb' )

run PgpIo::App.new
