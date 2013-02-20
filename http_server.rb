# -*- coding: utf-8 -*-

require 'socket'
require 'date'

load './config.rb'
load './http_content.rb'
load './thread_process.rb'
load './error.rb'

begin
  # 必要なものの確認、ログファイル設定
  HttpContent.setting
rescue => e
  p e.message
  exit
end

begin
  server = TCPServer.open("192.168.0.3", 3000)
  socks = [server]
  addr = server.addr
  addr.shift
  
  printf("server is on %s\n", addr.join(":"))
  $log.puts(addr.join(":"))
rescue => e
  p e.message
  $log.puts("Error: #{e.message}")
  exit
end

while
  Thread.start(server.accept){|socket|
    line = socket.gets
    begin
      request = line.split(" ")
      p request
      
      ThreadProcess.new(socket, request).run
    rescue => e
      p e.message
      $log.puts("Error: #{e.message}")
    end
    socket.close
    socks.delete(socket)
  }
end
server.close

