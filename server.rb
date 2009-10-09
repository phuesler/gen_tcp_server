require 'socket'

def handle_socket(socket)
    puts "New connection"
    until socket.closed? || socket.eof?
      input = socket.gets
      socket.write input
      puts input.inspect
    end
    socket.close
end

server = TCPServer.new('127.0.0.1', 6429)
puts "Server started"


loop {
  Thread.new(server.accept) do |socket|
    begin
      handle_socket socket
    rescue => e
      puts e.message
    ensure
      puts "Closing socket"
      socket.close
    end
  end
}