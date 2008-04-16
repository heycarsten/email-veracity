require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'rake/rdoctask'


desc 'Default: run unit tests.'
task :default => :test

desc 'Test the Email Veracity library'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end


# Packaging
spec = Gem::Specification.new do |spec|
  spec.name = 'email-veracity'
  spec.summary = 'A straight-forward library for checking the real-world
    validity of email addresses.'
  spec.version = File.read('VERSION').strip
  spec.author = 'Carsten Nielsen'
  spec.email = 'heycarsten@gmail.com'
  spec.description = 'Email Veracity is a set of simple classes that can be
    used to query an email address for information.'
  readmes = FileList.new('*'){|list|
    list.exclude(/[a-z]/)
    list.exclude('TODO') }.to_a
  spec.files = FileList['lib/**/*', 'bin/*', 'test/**/*', 'Rakefile',
    'init.rb'].to_a + readmes
  spec.autorequire = %w|  |
  spec.homepage = 'http://heycarsten.com'
  spec.has_rdoc = true
  spec.extra_rdoc_files = readmes
  spec.rdoc_options += [
    '--title', 'Email Veracity',
    '--main', 'README',
    #'--exclude', '?',
    '--line-numbers',
    '--inline-source'
  ]
  spec.test_files = FileList['test/**/*_test.rb'].to_a
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip     = true
  pkg.need_tar_gz  = true
  pkg.need_tar_bz2 = true
end

task :install => [:package] do
  `gem install --no-ri pkg/email-veracity-#{File.read('VERSION').strip}`
end


# Documentation
rdoc_task = Proc.new do |rdoc|
  rdoc.title = 'Email Veracity'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rake::RDocTask.new do |rdoc|
  rdoc_task.call(rdoc)
  rdoc.rdoc_dir = 'rdoc'
end