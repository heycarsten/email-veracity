require File.dirname(__FILE__) + '/../test_helper'


class ConfigTest < Test::Unit::TestCase

  def test_default_whitelist_domains
    assert_instance_of Array, EmailVeracity::Config[:whitelist]
    assert_not_empty EmailVeracity::Config[:whitelist],
      'Should have more than one item.'
  end

  def test_default_blacklist_domains
    assert_instance_of Array, EmailVeracity::Config[:blacklist]
    assert_not_empty EmailVeracity::Config[:blacklist],
      'Should have more than one item.'
  end

  def test_lookup_default_setting
    assert_instance_of Array, EmailVeracity::Config[:lookup]
  end

  def test_enforce_lookup_with_symbols
    assert EmailVeracity::Config.enforce_lookup?(:a),
      'Should check for A records by default'
    assert !EmailVeracity::Config.enforce_lookup?(:mx),
      'Should not check for MX records be default'
  end

  def test_enforce_lookup_with_strings
    assert EmailVeracity::Config.enforce_lookup?('a'),
      'Should check for A records by default'
    assert !EmailVeracity::Config.enforce_lookup?('mx'),
      'Should not check for MX records be default'
  end

  def test_changing_and_reverting_configuration
    EmailVeracity::Config.update(:lookup => false, :timeout => 3)
    assert_equal false, EmailVeracity::Config[:lookup],
      'Should change configuration.'
    assert_equal 3, EmailVeracity::Config[:timeout]
      'Should change configuration.'
    EmailVeracity::Config.revert!
    assert_equal EmailVeracity::Config::DEFAULT_OPTIONS,
      EmailVeracity::Config.options,
      'Should revert configuration'
  end

end


class DefaultValidAddressPatternTest < Test::Unit::TestCase

  def test_default_valid_address_pattern
    assert_instance_of Regexp, EmailVeracity::Config[:valid_pattern],
      'Should exist as a regular expression.'
  end

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
      assert_match EmailVeracity::Config[:valid_pattern],
        address,
        "#{address} should be valid."
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
      charles\ babbage@gmail.com
      ,@crap.com
      dis%20blos@dot.com
      &^%$#$%@yojimbo.nil
      "greetings\ friend"@comtastic.dk
      this,fails@ice-t.com
      ungültige@adresse.de
      failure@10.0.0.1
      douche@@bag.net
    ].each do |address|
      assert_no_match EmailVeracity::Config[:valid_pattern],
        address,
        "#{address} should be invalid."
    end
  end

end