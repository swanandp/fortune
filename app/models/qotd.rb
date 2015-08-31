require "net/telnet"

class Qotd
  # Get a fresh, random quote from one of the free servers mentioned here:
  # https://en.wikipedia.org/wiki/QOTD
  # If any server is down, automatically try the next
  # Fail if all servers fail to respond. Failure error: StopIteration
  def get(servers = self.class.servers)
    begin
      server = servers.next
      quote = get_from_server(server)
    rescue Net::OpenTimeout, Net::ReadTimeout, Errno::ECONNRESET
      # Only re-try fetch errors
      # When we run out of servers, simply let the exception rise up the stack
      # Job handler can then retry after some time
      Rails.logger.debug "Failed: #{server.inspect}. Moving on."
      retry
    rescue StopIteration
      raise ArgumentError, "No more servers left to try out. Please retry after some time."
    end

    quote
  end

  def get_from_server(server)
    Rails.logger.debug "Trying #{server.inspect}"

    connection = Net::Telnet.new(
      "Host" => server[:host],
      "Port" => server[:port]
    )

    quote = connection.cmd("\d")
    connection.close
    quote
  end

  # Immutable server collection
  # If this list grows big, we can move this into a file or a database
  def self.servers
    Enumerator.new do |yielder|
      yielder.yield host: "djxmmx.net", port: 17
      yielder.yield host: "mir.intstl.com", port: 17
      yielder.yield host: "alpha.mike-r.com", port: 17
      yielder.yield host: "home.kyleterry.com", port: 17
    end
  end

  # Syntax sugar for Qotd.new.get
  def self.get
    new.get
  end
end
