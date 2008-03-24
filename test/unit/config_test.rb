require File.dirname(__FILE__) + '/../test_helper'


class ConfigTest < Test::Unit::TestCase
  
  def test_get_default_whitelist_domains
    assert_equal Array, EmailVeracity::Config.options[:whitelist_domains].class, 'Should be an array.'
    assert EmailVeracity::Config.options[:whitelist_domains].size > 1, 'Should have more than one item.'
  end
  
  def test_get_default_blacklist_domains
    assert_equal Array, EmailVeracity::Config.options[:blacklist_domains].class, 'Should be an array.'
    assert EmailVeracity::Config.options[:blacklist_domains].size > 1, 'Should have more than one item.'
  end
  
  def test_get_default_valid_address_pattern
    assert_equal Regexp, EmailVeracity::Config.options[:valid_address_pattern].class, 'Should exist as a regular expression.'
  end
  
end


class DefaultValidAddressPatternTest < Test::Unit::TestCase
  
  def test_valid_email_addresses
    %w[
      goto@rubyfringe.ca
      stuff+heycarsten@gmail.com
      carsten_nielsen@gmail.com
      carsten-nielsen@gmail.com
      iwenttowestern@ivyleague.ca
      old-skool@mail.mysite.on.ca
      heycarsten@del.icio.us
      nex3@haml.town
      1234@aplace.com
      carsten2@happyland.net
      sweetCandy4@me-and-you.ca
      jesus@god.com
      neat@b.eat
    ].each do |address|
      assert_match EmailVeracity::Config.options[:valid_address_pattern], address, "#{address} should be valid."
    end
  end
  
  def test_invalid_email_addresses
    %w[
      @failure.net
      craptastic@
      !!!!!@gmail.com
      someone@f4iL/\/\@il.net
      someone@somewhere
      this!fails@comtown.com
      $oWrong@fail.net
      charles\ babbage@cabbage.org
      ,@crap.com
      dis%20blos@dot.com
      &^%$#$%@yojimbo.nil
      "greetings\ friend"@comtastic.dk
      this,fails@work.com
      ungültige@adresse.de
      failure@10.0.0.1
      douche@@bag.net
    ].each do |address|
      assert_no_match EmailVeracity::Config.options[:valid_address_pattern], address, "#{address} should be invalid."
    end
  end
  
end