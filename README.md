# Email Veracity

A straight-forward Ruby library for checking the real-world validity of email
addresses that you should probably not use.

## It Can

 * Validate email addresses for proper form against a pattern.
 * Accept and reject addresses based whitelists and blacklists of domains.
 * Check an address' domain for MX and/or A records.
 * Be configured for a variety of use-cases, to be as discerning or as
   indiscriminate as you would like.

## A Note About This Gem

I don't condone it for email validation. If you must be sure an address is
real then you should send a verification message. Otherwise, relax :-)

## Using The Gem

Consider the following examples:
    
    require 'email_veracity'
    
    address = EmailVeracity::Address.new('heycarsten@gmail.com')
    
    address.valid?
    # => true
    
    address.domain.to_s
    # => 'gmail.com'
    
    address.domain.address_servers.map { |s| s.to_s }
    # => ["64.233.171.83", "64.233.161.83", "209.85.171.83"]
    
    address = EmailVeracity::Address.new('fakey@crazy-z3d9df-domain.com')
    
    address.valid?
    # => false
    
    address.errors
    # => [:no_address_servers]

As you can see, playing with the core library is pretty fun.  The basic building
blocks are:

#### Address

Responsible for parsing full email addresses and checking for pattern-based
validity.

#### Domain

Contains methods to query the domain for information.

#### Resolver

Abstracts Resolv::DNS into a super-simple single public method, this is where
the timeout error is raised.
