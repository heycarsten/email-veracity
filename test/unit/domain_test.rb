require File.dirname(__FILE__) + '/../test_helper'


class DomainTest < Test::Unit::TestCase

  def test_blacklisted_domain
    assert EmailVeracity::Domain.blacklisted?('dodgeit.com'),
      'Should match a blacklisted domain.'
    assert EmailVeracity::Domain.blacklisted?('DoDgEiT.cOm'),
      'Should match a blacklisted domain regardless of case.'
    assert EmailVeracity::Domain.blacklisted?(" dodgeit.com  \r\n "),
      'Should match a blacklisted domain regardless of whitespace.'
    assert !EmailVeracity::Domain.blacklisted?('iamnotblacklisted.com'),
      'Should not match a non-blacklisted domain.'
  end

  def test_whitelisted_domain
    assert EmailVeracity::Domain.whitelisted?('gmail.com'),
      'Should match a whitelisted domain.'
    assert EmailVeracity::Domain.whitelisted?('GmAiL.cOm'),
      'Should match a whitelisted domain regardless of case.'
    assert EmailVeracity::Domain.whitelisted?(" gmail.com  \r\n "),
      'Should match a whitelisted domain regardless of whitespace.'
    assert !EmailVeracity::Domain.whitelisted?('iamnotwhitelisted.com'),
      'Should not match a non-whitelisted domain.'
  end

  def test_initializing_a_new_domain_with_whitespace
    domain = new_domain('  heycarsten.com  ')
    assert_equal 'heycarsten.com', domain.name, 'Should strip whitespace.'
    assert_respond_to domain, :to_s, 'Should have a to_s method.'
  end

  def test_a_valid_domain_for_address_servers
    domain_name = 'gmail.com'
    domain = new_domain(domain_name)
    EmailVeracity::Resolver.expects(:get_servers_for).with(domain_name.strip, :a).returns(["mail.#{domain_name}"])
    
    assert_not_empty domain.address_servers, 'Should contain address servers.'
  end

  def test_a_valid_domain_for_exchange_servers
    domain_name = 'gmail.com'
    domain = new_domain(domain_name)
    EmailVeracity::Resolver.expects(:get_servers_for).with(domain_name.strip, :mx).returns(["mail.#{domain_name}"])
    
    assert_not_empty domain.exchange_servers, 'Should contain mail servers.'
  end

  def test_a_valid_domain_with_whitespace_for_address_servers
    domain_with_whitespace = '  learnhub.com  '
    domain = new_domain(domain_with_whitespace)
    EmailVeracity::Resolver.expects(:get_servers_for).with(domain_with_whitespace.strip, :a).returns(%w(mail.learnhub.com))
    
    assert_not_empty domain.address_servers, 'Should contain address servers.'
  end

  def test_a_valid_domain_with_whitespace_for_exchange_servers
    domain_with_whitespace = '  learnhub.com  '
    domain = new_domain(domain_with_whitespace)
    EmailVeracity::Resolver.expects(:get_servers_for).with(domain_with_whitespace.strip, :mx).returns(%w(mail.learnhub.com))
    
    assert_not_empty domain.exchange_servers, 'Should contain address servers.'
  end

  def test_an_invalid_domain_for_address_servers
    domain = new_domain('i-surely-do-not.exist')
    domain.expects(:servers_in).with(:a).returns([])

    assert_empty domain.address_servers, 'Should not contain address servers.'
  end
  
  def test_an_invalid_domain_for_exchange_servers
    domain = new_domain('i-surely-do-not.exist')
    domain.expects(:servers_in).with(:mx).returns([])
    
    assert_empty domain.exchange_servers, 'Should not contain exchange servers.'
  end

  def test_a_blank_domain_for_servers
    domain = new_domain('')
    assert_empty domain.exchange_servers, 'Should not contain exchange servers.'
    assert_empty domain.address_servers, 'Should not contain address servers.'
  end

  def test_for_errors_on_a_valid_domain
    domain = new_domain('yahoo.com')
    assert_empty domain.errors, 'Should not have errors.'
  end

  def test_for_errors_on_an_invalid_domain
    domain = new_domain('i-surely-do-not.exist')
    domain.expects(:address_servers).returns([])
    domain.expects(:exchange_servers).returns([])
    
    assert_not_empty domain.errors, 'Should have errors.'
  end

  private
    def new_domain(name = 'heycarsten.com')
      EmailVeracity::Domain.new(name)
    end

end