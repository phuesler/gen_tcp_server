require 'socket'

def handle_socket(socket)
    until socket.closed?
      buf = ''
      until buf =~ /\n\n\z/ || socket.eof? || socket.closed?
        buf << socket.read(1).to_s
      end
      puts buf.inspect
    end
end

server = TCPServer.new('127.0.0.1', 6429)
puts "Server started"


loop {
  Thread.new(server.accept) do |socket|
    begin
      handle_socket socket
    rescue => e
      socket.close
      puts e.message
    end
  end
}