module EmailVeracity


  class Error < StandardError; end


  class MalformedEmailAddressError < Error; end


  class DomainResourcesTimeoutError < Error

    attr_accessor :domain

  end


end