# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "foreman_param_lookup"
  gem.homepage = "https://github.com/sfu-rcg/foreman_param_lookup.git"
  gem.license = "GPL-3"
  gem.summary = %Q{Allows you to search for a record via fqdn, clientcert, or mac, and return its class parameter values}
  gem.description = %Q{Allows you to search for a record via fqdn, clientcert, or mac, and return its class parameter values}
  gem.email = "rshott@sfu.ca"
  gem.authors = ["Riley Shott"]
  # dependencies defined in Gemfile
end

task :default => :test
