Email Veracity
==============

A straight-forward Ruby library for checking the real-world validity of email
addresses.


### It Can

 * Validate email addresses for proper form against a pattern.
 * Accept and reject addresses based whitelists and blacklists of domains.
 * Check an address' domain for MX and/or A records.
 * Be configured for a variety of use-cases, to be as discerning or as
   indiscriminate as you would like.


### It Can Not

 * Validate all possible permutations of addresses to the RFC 2822
   specification.


A Note About The ActiveRecord Plugin
------------------------------------

**It's dead!** Why? Determining the validity of an email address based on a lookup of its domain is a good idea, but basing it off of one single test done inline with a request is not. A name server might be down, shit happens, and you might be snubbing a totally legitimate person from using your product &mdash; not good.

I feel a better solution is to check the pattern of the email address and perhaps check it against the blacklist on creation. The other tests should be done in the background over the period of many days and be added to a log. A report can then be performed and you can statistically determine the addresses that are most likely false and take appropriate action from that point. 


Using The Gem
-------------

In your project, you must require `email_veracity` after that you can try it
out, consider the following examples:

    
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
