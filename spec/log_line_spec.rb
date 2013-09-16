require 'rubygems'
require 'rspec'
require 'rack'

require File.expand_path(File.dirname(__FILE__) + '/../lib/log_line.rb')

describe LogLine do
  it 'LogLine.guess_type' do
    LogLine.guess_type(Rack::Utils.escape_html '<< /home/example/.znc/users/example/moddata/log/#example.log >>').should == :title
    LogLine.guess_type(Rack::Utils.escape_html '[00:00:00] *** Joins: example_user (~example_user@example.com) ("Leaving...")').should == :system
    LogLine.guess_type(Rack::Utils.escape_html '[00:00:00] *** Quits: example_user (~example_user@example.com) ("Leaving...")').should == :system
    LogLine.guess_type(Rack::Utils.escape_html '[00:00:00] <example_user> おはようございます。').should == :user
    LogLine.guess_type(Rack::Utils.escape_html '[00:00:00] <example_user> [00:00:00] *** Quits: example_user (~example_user@example.com) ("Leaving...")').should == :user
    LogLine.guess_type(Rack::Utils.escape_html 'hoge').should == :none
  end  
end
