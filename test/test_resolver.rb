require 'helper'

class TestResolver < Test::Unit::TestCase

  DOMAIN_NAMES = %w[
    viarails.net heycarsten.com yahoo.com gmail.com savvica.com
    okayfail.com github.com google.com rogers.com amd.com adobe.com
    unspace.ca xerox.com webkit.org cooltown.net aiderss.com delicious.com ]

  def test_consecutive_queries
    DOMAIN_NAMES.each do |domain_name|
      EmailVeracity::Resolver.stubs(:get_resources_for).
        with(domain_name, kind_of(Symbol)).returns(["mail.#{domain_name}"])
    end
    assert_nothing_raised do
      DOMAIN_NAMES.each do |domain|
        assert_instance_of Array, EmailVeracity::Resolver.get_servers_for(domain),
          'Should return an array of servers'
      end
    end
  end

  def test_timing_out_while_resolving_a_domain
    domain = 'okayfail.com'
    timeout_exception = Timeout::Error.new('The connection has timed out')
    EmailVeracity::Resolver.stubs(:get_resources_for).
      with(domain, kind_of(Symbol)).raises(timeout_exception)
    assert_raise EmailVeracity::DomainResourcesTimeoutError, 'Should time out' do
      EmailVeracity::Resolver.get_servers_for(domain)
    end
  end

end
