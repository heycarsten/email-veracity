require 'rubygems'
require 'rake'

EMAIL_VERACITY_GEMSPEC = Gem::Specification.new do |spec|
  spec.rubyforge_project = spec.name = 'email-veracity'
  spec.summary = 'A straight-forward Ruby library for checking the real-world validity of email addresses.'
  spec.version = File.read('VERSION').strip
  spec.authors = ['Carsten Nielsen']
  spec.email = 'heycarsten@gmail.com'
  spec.description = <<-EOF
Email Veracity abstracts an email address into a series of objects which makes
it easy to see if an address is invalid, and if so, why.
EOF
  readmes = FileList.new('*') { |list|
    list.exclude(/(^|[^.a-z])[a-z]+/)
    list.exclude('TODO') }.to_a
  spec.files = FileList['lib/**/*', 'test/**/*', 'Rakefile', 'init.rb'].to_a + readmes
  spec.homepage = 'http://github.com/heycarsten/email-veracity/tree/master'
  spec.has_rdoc = true
  spec.extra_rdoc_files = readmes
  spec.rdoc_options += [
    '--title', 'Email Veracity',
    '--main', 'README.rdoc',
    '--line-numbers',
    '--inline-source' ]
  spec.test_files = FileList['test/**/*_test.rb'].to_a
end