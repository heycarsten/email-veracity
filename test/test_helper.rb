require 'test/unit'
require 'lib/email_veracity'
Dir.glob('test/mocks/*.rb') { |f| require(f) }


class Test::Unit::TestCase

  def domain_names
    %w[ viarails.net  heycarsten.com  yahoo.com  gmail.com  savvica.com
      learnhub.com  github.com  google.com  rogers.com  amd.com  adobe.com
      unspace.ca  xerox.com  webkit.org  cooltown.net  aiderss.com
      del.icio.us ]
  end

end