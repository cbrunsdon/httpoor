require 'socket'

server = TCPServer.new 9906
while true do
  client = server.accept

  # First line is the HTTP line... so we can cheat and just grab it for now
  http_line = client.readline

  #puts http_line # don't print anything to the console, too slow

  requested_file = http_line.match(/GET (.*) HTTP/)[1]

  filename = File.join('public', requested_file)

  if File.exist?(filename)
    file = File.open(filename)
    client.puts "HTTP/1.1 200 OK"
    client.puts "Content-Type: text/plain"
    client.puts ""
    client.puts file.read
  end
  client.close
end
