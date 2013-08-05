#!/usr/bin/env ruby

require "sinatra"
require "yaml"

class Logirc < Sinatra::Base
  enable :logging

  config = YAML.load(open(File.dirname( __FILE__ ) + "/config/config.yml"))
  logdir = config["logdir"]

  if config["user"].to_s.length > 0
    use Rack::Auth::Basic do |username, password|
      username == config["user"] && password == config["password"]
    end
  end

  get %r{/(.*)$} do |c|
    @files = Dir.glob "#{logdir}\#*.log"
    if (c.length > 0)
      file = logdir + "#" + c
    else
      file = @files.last
    end
    logs = ""
    open(file) do |f|
      logs = logs + "<< " + file + " >>\n" + f.read + "\n"
    end
    @logs = Rack::Utils.escape_html(logs)
    erb :logirc, :layout => false
  end
end
