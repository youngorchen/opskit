# encoding=UTF-8
# -*- coding: UTF-8 -*-
# coding: UTF-8

require 'rubygems'

require 'net/ssh'
require 'sinatra'
require "sinatra/basic_auth"
require 'sinatra/flash'

set :public_folder, '/tmp/'
enable :sessions  #enable flash....


authorize "Admin" do |username, password|
  username == 'admin' && password == '****'
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
        Dir.glob("/tmp/*#{fix}").each { | fn | 
            puts fn
            fn = File.basename(fn)
            str += "<p><a href=\"#{fn}\">#{fn}</a>"
            str += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            str += "<a href=\"rmfn/#{fn}\">删除</a>"
            str +="</p>"
        }
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


end



def hi
 host = '172.16.0.'
 user = 'root'
 pass = '***'
 port = 23

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

