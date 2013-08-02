require 'rubygems' unless defined? ::Gem
require File.dirname( __FILE__ ) + '/logirc'

Logirc.run! :host => "0.0.0.0", :port => 26668, :environment => "production"
