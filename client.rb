EM.epoll
EM.run do
  trap("TERM") { stop }
  trap("INT")  { stop }

  @host = "ws://sandbox.spacebrew.cc:9000"
  @description = "Basic SpaceBrew Ruby example app"
  @app_name = "SpaceBruby"

  ws = WebSocket::EventMachine::Client.connect(:uri => @host)

  ws.onopen do
    puts "Connected"
    #ws.send "Hello Server!"
  end

  ws.onmessage do |msg, type|
    puts "Received message: #{msg}"
  end

  ws.onclose do
    puts "Disconnected"
  end

  def stop
    puts "Terminating connection"
    EventMachine.stop
  end

end