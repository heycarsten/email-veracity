#### DEPRECATION NOTICE

Email Veracity was my very first open source project. Six years ago, it seemed
like a cool idea, but it's now pretty common knowledge that trying to validate
email addresses beyond a loose format check will likely yield false-positives.
The whole idea of including a library for that seems silly.

***

# Email Veracity 101

Let's explore the different functionality that Email Veracity provides and some
simple ways you can integrate this functionality into your code
without needing to rely on a flaky guy like me!

### Validating an address for format

Trying to explicitly validate an email address for total RFC compliance is
extravagantly complex, so why bother? Send a verification email to ensure that
the user has provided a functioning address. If you still think that having a
more robust check is necessary, the
[regex](https://github.com/heycarsten/email-veracity/blob/master/lib/email_veracity/config.rb#L25-L61)
used in Email Veracity is from
[here](http://fightingforalostcause.net/content/misc/2006/compare-email-regex.php)
and is a pretty good compromise between obscene complexity and useful
robustness.

```ruby
email = 'bizdude@example.biz'

if email =~ /\A[^@]+@[^@]+\Z/
  puts 'probably valid'
  send_verification_to(email)
else
  puts 'definately not valid'
end
```

### Extracting the domain portion of an email address

There are libraries out there for formally parsing email addresses and you can
use those to get the domain portion of the email address, but we can also just
use a little regular expression.

```ruby
email = 'megabiz@social-expert-megasite-seo.com'
match = /@([\w\.\-]+)\Z/i =~ email

if match
  puts 'domain is: ' + match[1]
else
  puts 'no domain found'
end
```

### Looking up records on the domain

I highly discourage using this method to actually validate email addresses
in-line with a request; it will *absolutely* yield false-positives.

```ruby
require 'resolv'

A  = Resolv::DNS::Resource::IN::A  # Address records
MX = Resolv::DNS::Resource::IN::MX # Mail-exchange records
NS = Resolv::DNS::Resource::IN::NS # Name server records

def lookup(host, type)
  Resolv::DNS.new.getresources(host, type)
end

a_records  = lookup('gmail.com', A)
mx_records = lookup('gmail.com', MX)
ns_records = lookup('gmail.com', NS)

puts a_records.map { |r| r.address.to_s }
puts mx_records.map { |r| r.exchange.to_s }
puts ns_records.map { |r| r.name.to_s }
```

Check out the
[Ruby Standard Library Documentation](http://www.ruby-doc.org/stdlib-2.0.0/libdoc/resolv/rdoc/Resolv/DNS.html)
for more ways to use Resolv::DNS in your project.
