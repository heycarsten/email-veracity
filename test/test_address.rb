require 'helper'


class TestAddress < Test::Unit::TestCase

  def test_initialize
    assert_instance_of EmailVeracity::Address,
      EmailVeracity::Address.new('heycarsten@gmail.com'),
      'Should create a new Address object.'
    assert_instance_of Array,
      EmailVeracity::Address.new('heycarsten@gmail.com').errors,
      '#errors should be an array.'
  end

end


class DefaultConfigurationAddressValidationsTest < Test::Unit::TestCase

  def test_a_nil_address_argument
    address = new_address(nil)
    assert !address.valid?, 'Should be invalid.'
  end

  def test_a_well_formed_address_with_a_whitelisted_domain
    address = new_address('heycarsten@gmail.com')
    assert address.valid?, "Should be valid. @errors: #{address.errors.inspect}"
  end

  def test_a_well_formed_address_with_a_blacklisted_domain
    address = new_address('heycarsten@dodgeit.com')
    address.stubs(:domain).returns(stub(:errors => [:blacklisted]))
    assert !address.valid?, "Should not be valid. @errors: #{address.errors.inspect}"
  end

  def test_a_well_formed_address_that_does_not_exist
    address = new_address('heycarsten@i-surely-do-not-exist.nil')
    address.stubs(:domain).returns(stub(:errors => [:no_records]))
    assert !address.valid?, 'Should not be valid.'
  end

  def test_a_well_formed_address_that_exists
    address = new_address('itsme@heycarsten.com')
    address.stubs(:domain).returns(stub(:errors => []))
    assert address.valid?, "Should be valid. @errors: #{address.errors.inspect}"
  end

  private

  def new_address(address = '')
    EmailVeracity::Address.new(address)
  end

end
