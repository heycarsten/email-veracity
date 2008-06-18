module EmailVeracity


  class Error < StandardError; end
  class MalformedEmailAddressError < Error; end
  class DomainResourcesTimeoutError < Error; end


end