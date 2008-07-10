EV_VERSION = '0.3.0'
EV_GEMSPEC = Gem::Specification.new do |s|
  s.name = 'email-veracity'
  s.version = EV_VERSION
  s.author = 'Carsten Nielsen'
  s.email = 'heycarsten@gmail.com'
  s.summary = 'A simple library for checking the real-world validity of email addresses.'
  s.description = 'Email Veracity abstracts an email address into a series of objects which makes it easy to see if an address is invalid, and if so, why.'
  s.homepage = 'http://github.com/heycarsten/email-veracity'
  s.rubyforge_project = 'email-veracity'
  s.files = %w[
    lib/email_veracity/address.rb
    lib/email_veracity/config.rb
    lib/email_veracity/core_extensions.rb
    lib/email_veracity/domain.rb
    lib/email_veracity/errors.rb
    lib/email_veracity/resolver.rb
    lib/email_veracity/server.rb
    lib/email_veracity/validatability.rb
    lib/email_veracity.rb
    README.rdoc
    Rakefile
    init.rb ]
  s.has_rdoc = true
  s.extra_rdoc_files = %w[ README.rdoc ]
  s.rdoc_options += [
    '--title', 'Email Veracity',
    '--main', 'README.rdoc',
    '--line-numbers',
    '--inline-source']
  s.test_files = Dir.glob('test/*.rb')
end