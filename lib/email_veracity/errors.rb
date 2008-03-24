module EmailVeracity
  
  class Error < StandardError; end
  class MalformedEmailAddressError < Error; end
  class ServerQueryTimeoutError < Error; end
  
end