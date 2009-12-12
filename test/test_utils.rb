require 'helper'

class TestUtils < Test::Unit::TestCase

  def test_blank
    assert EmailVeracity::Utils.blank?([]), '[] should be blank.'
    assert EmailVeracity::Utils.blank?(''), '"" should be blank.'
    assert EmailVeracity::Utils.blank?(Hash.new), '{} should be blank.'
    assert EmailVeracity::Utils.blank?(nil), 'nil should be blank.'
  end

end
