require File.dirname(__FILE__) + '/../test_helper'


class AddressTest < Test::Unit::TestCase
  
  def test_initialize
    assert_equal EmailVeracity::Address, EmailVeracity::Address.new('heycarsten@gmail.com').class, 'Should create a new Address object.'
    assert_equal Array, EmailVeracity::Address.new('heycarsten@gmail.com').errors.class, 'Should errors should be an array.'
  end
  
end


class DefaultConfigurationAddressValidationsTest < Test::Unit::TestCase
  
  def test_a_well_formed_address_with_a_whitelisted_domain
    new_address = EmailVeracity::Address.new('heycarsten@gmail.com')
    assert new_address.valid?, "Should be valid. @errors: #{new_address.errors.inspect}"
  end
  
  def test_a_well_formed_address_with_a_blacklisted_domain
    new_address = EmailVeracity::Address.new('heycarsten@dodgeit.com')
    assert new_address.valid?, "Should be valid. @errors: #{new_address.errors.inspect}"
  end
  
end