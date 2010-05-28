require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'email_veracity'


class ClassWithValidationMock

  include EmailVeracity::Validatability

  attr_accessor :give_error
  attr_accessor :give_errors
  attr_accessor :give_array_of_errors

  def validate!
    add_error(:one) if give_error
    add_errors(:two, :three) if give_errors
    add_errors([:four, :five]) if give_array_of_errors
    add_errors []
  end

end


class Test::Unit::TestCase

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
