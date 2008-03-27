require File.dirname(__FILE__) + '/../test_helper'


class ConfigTest < Test::Unit::TestCase
  
  def test_default_whitelist_domains
    assert_equal Array, EmailVeracity::Config.options[:whitelist_domains].class, 'Should be an array.'
    assert EmailVeracity::Config.options[:whitelist_domains].size > 1, 'Should have more than one item.'
  end
  
  def test_default_blacklist_domains
    assert_equal Array, EmailVeracity::Config.options[:blacklist_domains].class, 'Should be an array.'
    assert EmailVeracity::Config.options[:blacklist_domains].size > 1, 'Should have more than one item.'
  end
  
  def test_default_valid_address_pattern
    assert_equal Regexp, EmailVeracity::Config.options[:valid_address_pattern].class, 'Should exist as a regular expression.'
  end
  
  def test_blacklisted_domain
    assert EmailVeracity::Config.blacklisted_domain?('dodgeit.com'), 'Should match a blacklisted domain.'
    assert EmailVeracity::Config.blacklisted_domain?('DoDgEiT.cOm'), 'Should match a blacklisted domain regardless of case.'
    assert EmailVeracity::Config.blacklisted_domain?(" dodgeit.com  \r\n "), 'Should match a blacklisted domain regardless of whitespace.'
    assert !EmailVeracity::Config.blacklisted_domain?('iamnotblacklisted.com'), 'Should not match a non-blacklisted domain.'
  end
  
  def test_whitelisted_domain
    assert EmailVeracity::Config.whitelisted_domain?('gmail.com'), 'Should match a whitelisted domain.'
    assert EmailVeracity::Config.whitelisted_domain?('GmAiL.cOm'), 'Should match a whitelisted domain regardless of case.'
    assert EmailVeracity::Config.whitelisted_domain?(" gmail.com  \r\n "), 'Should match a whitelisted domain regardless of whitespace.'
    assert !EmailVeracity::Config.whitelisted_domain?('iamnotwhitelisted.com'), 'Should not match a non-whitelisted domain.'
  end
  
end


class DefaultValidAddressPatternTest < Test::Unit::TestCase
  
  def test_valid_email_addresses
    %w[
      goto@rubyfringe.ca
      stuff+heyd00d@gmail.com
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
      oh-noez@f4iL/\/\@il.net
      someone@somewhere
      this!fails@comtown.com
      $oWrong@fail.net
      charles\ babbage@cabbage.org
      ,@crap.com
      dis%20blos@dot.com
      &^%$#$%@yojimbo.nil
      "greetings\ friend"@comtastic.dk
      this,fails@ice-t.com
      ungültige@adresse.de
      failure@10.0.0.1
      douche@@bag.net
    ].each do |address|
      assert_no_match EmailVeracity::Config.options[:valid_address_pattern], address, "#{address} should be invalid."
    end
  end
  
end