require 'rake'
require 'rubygems'

EMAIL_VERACITY_GEMSPEC = Gem::Specification.new do |s|
  s.name = 'email-veracity'
  s.version = File.read('VERSION').strip
  s.authors = ['Carsten Nielsen']
  s.email = 'heycarsten@gmail.com'
  s.summary = 'A straight-forward Ruby library for checking the real-world validity of email addresses.'
  s.description = %|
    Email Veracity abstracts an email address into a series of objects which makes
    it easy to see if an address is invalid, and if so, why.|
  # We need the revision file to exist,
  # so we just create it if it doesn't.
  # It'll usually just get overwritten, though.
  File.open('REVISION', 'w') { |f| f.puts '(unknown)' } unless File.exist?('REVISION')
  readmes = FileList.new('*') do |list|
    list.exclude(/(^|[^.a-z])[a-z]+/)
    list.exclude('TODO')
    list.include('REVISION')
  end.to_a
  s.files = FileList['lib/**/*', 'test/**/*', 'Rakefile', 'init.rb'].to_a + readmes
  s.homepage = 'http://github.com/heycarsten/email-veracity'
  s.has_rdoc = true
  s.extra_rdoc_files = readmes
  s.rdoc_options += [
    '--title', 'Email Veracity',
    '--main', 'README.rdoc',
    '--line-numbers',
    '--inline-source']
  s.test_files = FileList['test/**/*_test.rb'].to_a
end