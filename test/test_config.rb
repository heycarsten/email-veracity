# coding: utf-8

require 'helper'

class TestConfig < Test::Unit::TestCase

  VALID_EMAIL_ADDRESS_EXAMPLES = %w[
    goto@rubyfringe.ca
    went.to@futureruby.com
    heyd00d+stuff@gmail.com
    carsten_nielsen@gmail.com
    carsten-nielsen@gmail.com
    goodoldemail@address.ca
    old-skool@mail.mysite.on.ca
    heycarsten@del.icio.us
    nex3@haml.town
    1234@aplace.com
    carsten2@happyland.net
    sweetCandy4@me-and-you.ca
    technically.accurate@10.0.0.1
    simple@example.com
    -@iamdash.net
    _@underscoreface.com
    neat@b.eat
    &^%$#$%@yojimbo.nil
    i@shouldwork.com
    this+should+not+work+but+it+does+because+the+internet+told+me+to%20@dot.com
    +_-@justaccepteverything.ca
    $oRight@example.com
    !!!!!@gmail.com
    this!is.actually.ok@comtown.com
    1@shouldworktoo.com ]
  INVALID_EMAIL_ADDRESS_EXAMPLES = %w[
    two@email.com\ addresses@example.com
    @failure.net
    craptastic@
    oh-noez@f4iL/\/\@il.net
    fail..horribly@org.net
    someone@somewhere
    charles\ babbage@gmail.com
    ,@crap.com
    "greetings\ friend"@comtastic.dk
    this,fails@ice-t.com
    ungültige@adresse.de
    iamat@@at.net
    .@fail.net ]

  context 'Default email pattern' do
    should 'match valid addresses' do
      VALID_EMAIL_ADDRESS_EXAMPLES.each do |example|
        assert_match EmailVeracity::Config[:valid_pattern], example
      end
    end

    should 'not match invalid addresses' do
      INVALID_EMAIL_ADDRESS_EXAMPLES.each do |example|
        assert_no_match EmailVeracity::Config[:valid_pattern], example
      end
    end
  end

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

  def test_must_include_default_setting
    assert_instance_of Array, EmailVeracity::Config[:must_include]
  end

  def test_enforced_record_with_symbols
    assert !EmailVeracity::Config.enforced_record?(:a),
      'Should not check for A records by default'
    assert !EmailVeracity::Config.enforced_record?(:mx),
      'Should not check for MX records be default'
  end

  def test_enforce_lookup_with_strings
    assert !EmailVeracity::Config.enforced_record?('a'),
      'Should not check for A records by default'
    assert !EmailVeracity::Config.enforced_record?('mx'),
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
