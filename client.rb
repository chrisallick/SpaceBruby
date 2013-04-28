EM.epoll
EM.run do
    trap("TERM") { stop }
    trap("INT")  { stop }

    @host = "ws://sandbox.spacebrew.cc:9000"
    @description = "Basic SpaceBrew Ruby example app"
    @name = "SpaceBruby"
    @connected = false

    @client_config = { :name => @name, :description => @description, :publish => { :messages => [] }, :subscribe => { :messages => [] } }

    @ws = WebSocket::EventMachine::Client.connect(:uri => @host)

    @ws.onopen do
        puts "Connected"
        @connect = true
        update_pub_sub
    end

    def update_pub_sub
        @ws.send( { :config => @client_config }.to_json )
    end

    def send_msg( name, type, value )
        msg = { :clientName => @name, :name => name, :type => type, :value =>value }
        @ws.send( { :message => { :message => msg } }.to_json )
    end

    @ws.onmessage do |msg, type|
        puts "Received message: #{msg}"
    end

    @ws.onclose do
        @connected = false
        puts "Disconnected"
    end

    def stop
        puts "Terminating connection"
        EventMachine.stop
    end

end