# encoding=UTF-8
# -*- coding: UTF-8 -*-
# coding: UTF-8

require 'rubygems'

require 'net/ssh'
require 'sinatra'
require "sinatra/basic_auth"
require 'sinatra/flash'
require 'redis'
require 'date'

unless defined? $r
  $r = Redis.new :host => "172.16.0.240", :port => 6379
end


set :public_folder, '/tmp/'
enable :sessions


authorize "Admin" do |username, password|
  username == 'admin' && password == '######'
end



protect "Admin" do
  get '/' do
    str = ''
    if flash[:blah]
        str += flash[:blah]
    end
    
    str += "<p></p>"

    #'...pub' + hi
    
    ['.csv','.txt','.xls'].each do |fix|
      begin
        Dir.glob("/tmp/*#{fix}").each { | fn | 
            puts fn
            fn = File.basename(fn)
            str += "<p><a href=\"#{fn}\">#{fn}</a>"
            str += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            str += "<a href=\"rmfn/#{fn}\">删除</a>"
            str +="</p>"
        }
      rescue
        next
      end
    end

    str
  end

  get '/rmfn/:fn' do
    fn = "/tmp/" + params['fn']
    puts res = `rm  -rf #{fn}`.to_i

    flash[:blah] = "del successful! #{fn}! res:[#{res}]"  
    # sleep 10
    redirect "/"
  end

  get '/blah' do
      # This message won't be seen until the NEXT Web request that accesses the flash collection
      flash[:blah] = "You were feeling blah at #{Time.now}."
      
      # Accessing the flash displays messages set from the LAST request
      "Feeling blah again? That's too bad. #{flash[:blah]}"
  end

  get '/log' do
    str = '<html><head><meta http-equiv="refresh" content="5" /></head><body>'
    str += "#{DateTime.now}:     (" + $r.llen('MCC_SCT_VIP_REDIS_LISTENER_KEY').to_s + ")"
    str += "</body></html>"
  end

end



def hi
 host = '172.16.0.'
 user = 'root'
 pass = '###########'
 port = 2014

(31..31).each do |ip|
 Net::SSH.start( "#{host}#{ip}", user, :password => pass , :port => port) do|ssh|
   puts "-------"*12
   puts "IP:"+host+ip.to_s
   puts "-------"*12

   result = ssh.exec!('df -lh')
   return result.to_s
 end
end
end


