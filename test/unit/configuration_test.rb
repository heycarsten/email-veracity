require File.dirname(__FILE__) + '/../test_helper'


class ConfigurationTest < Test::Unit::TestCase
  
  def test_class_accessors
    config_copy = EmailVeracity::Configuration.clone # <= Clone so we don't screw the other tests.
    assert_class_accessor config_copy, :whitelist_domains, %w[ good.com domains.ca ]
    assert_class_accessor config_copy, :blacklist_domains, %w[ bad.net domains.org ]
    assert_class_accessor config_copy, :valid_address_pattern, /yay a regex/
  end
  
  def test_get_default_whitelist_domains
    assert_equal Array, EmailVeracity::Configuration.whitelist_domains.class, 'Should be an array.'
    assert EmailVeracity::Configuration.whitelist_domains.size > 1, 'Should have more than one item.'
  end
  
  def test_get_default_blacklist_domains
    assert_equal Array, EmailVeracity::Configuration.blacklist_domains.class, 'Should be an array.'
    assert EmailVeracity::Configuration.blacklist_domains.size > 1, 'Should have more than one item.'
  end
  
  def test_get_default_valid_address_pattern
    assert_equal Regexp, EmailVeracity::Configuration.valid_address_pattern.class, 'Should exist as a regular expression.'
  end
  
  protected
    def assert_class_accessor(klass, accessor, data)
      assert_block "Should have #{klass}::#{accessor} accessor should be settable and gettable." do
        begin
          klass.method("#{accessor}=").call(data)
          klass.method(accessor.to_s).call == data
        rescue ArgumentError
          false
        end
      end
    end
    
end


class DefaultValidAddressPatternTest < Test::Unit::TestCase
  
  def test_valid_email_addresses
    %w[
      heycarsten@gmail.com
    ].each do |address|
      assert_match EmailVeracity::Configuration.valid_address_pattern, address, "#{address} should be valid."
    end
  end
  
  def test_invalid_email_addresses
    %w[
      !!!!!@gmail.com
    ].each do |address|
      assert_no_match EmailVeracity::Configuration.valid_address_pattern, address, "#{address} should be invalid."
    end
  end
  
end