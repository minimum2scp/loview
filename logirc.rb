#!/usr/bin/env ruby

require "sinatra"
require "yaml"
require File.expand_path(File.dirname(__FILE__) + '/lib/log_line')

class Logirc < Sinatra::Base
  enable :logging

  config = YAML.load(open(File.dirname( __FILE__ ) + "/config/config.yml"))
  logdir = config["logdir"]
  logfile_pat = config["logfile_pat"]

  if config["user"].to_s.length > 0
    use Rack::Auth::Basic do |username, password|
      username == config["user"] && password == config["password"]
    end
  end

  get %r{/(.*)$} do |c|
    @channels = config["channels"]
    @files = Dir.glob("#{logdir}#{logfile_pat}").reverse
    @channels.each do |name,h|
      h["files"] = @files.select{|f| f.match(h["files_pat"])}
    end
    if (c.length > 0)
      file = logdir + "#" + c
    else
      begin
        file = @channels.first[1]["files"].first
        file ||= @files.first
      rescue
        file = @files.first
      end
    end
    logs = ""
    open(file) do |f|
      logs = logs + "<< " + file + " >>\n" + f.read + "\n"
    end
    @logs = Rack::Utils.escape_html(logs)
    erb :logirc, :layout => false
  end
end
