require 'rubygems'
require 'test/unit'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/email_veracity'
Dir.glob('test/mocks/*.rb') { |f| require(f) }


class Test::Unit::TestCase

  def domain_names
    %w[ viarails.net  heycarsten.com  yahoo.com  gmail.com  savvica.com
      learnhub.com  github.com  google.com  rogers.com  amd.com  adobe.com
      unspace.ca  xerox.com  webkit.org  cooltown.net  aiderss.com
      del.icio.us ]
  end

  def assert_empty(array, message = nil)
    unless array.is_a?(Array)
      raise ArgumentError, 'First argument must be an Array'
    end
    message = [message, "Expected #{array.inspect} to be empty."].
      flatten.join("\n")
    assert_block(message) { array.empty? }
  end

  def assert_not_empty(array, message = nil)
    unless array.is_a?(Array)
      raise ArgumentError, 'First argument must be an Array'
    end
    message = [message, "Expected #{array.inspect} to contain items."].
      flatten.join("\n")
    assert_block(message) { !array.empty? }
  end

end