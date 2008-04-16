require 'test/unit'
require 'lib/email_veracity'
Dir.glob('test/mocks/*.rb') { |f| require(f) }


class Test::Unit::TestCase
  
  def domain_names
    # %w[ 3com.com  adobe.com  alcoa.com  allied.com  alphacdc.com  amd.com
    #   amdahl.com  apple.com  att.com  bbn.com  bdm.com  bell-atl.com
    #   bellcore.com  boeing.com  cayman.com  ccur.com  cfg.com  cgi.com  ci.com
    #   cisco.com  convergent.com  cts.com  das.com  data-io.com  datacube.com
    #   dec.com  dg.com  dsc.com  dupont.com  entity.com  fluke.com  fmc.com
    #   ge.com  gene.com  gmr.com  grebyn.com  gte.com  hp.com  ibm.com  ide.com
    #   inmet.com  intel.com  isc.com  itcorp.com  kai.com  kccs.com  kesmai.com
    #   ksr.com  lockheed.com  marble.com  mcc.com  mentat.com  mentor.com
    #   ncr.com  nec.com  nma.com  northrop.com  nsc.com  nynexst.com 
    #   octopus.com  parcplace.com  peregrine.com  philips.com  portal.com
    #   prime.com  pyramid.com  quad.com  quick.com  ray.com  rdl.com
    #   rosemount.com  rosetta.com  sco.com  siemens.com  slb.com  spdcc.com
    #   spectra.com  q.com  sri.com  stargate.com  sun.com  symbolics.com
    #   tandy.com  tek.com  teltone.com  think.com  ti.com  tic.com  toad.com
    #   trw.com  tti.com  ub.com  unipress.com  unisys.com  vortex.com  wlk.com
    #   wyse.com  xerox.com ]
    %w[ viarails.net  heycarsten.com  yahoo.com  gmail.com  savvica.com
      learnhub.com  github.com  google.com  dupont.com  amd.com  adobe.com
      unspace.ca  xerox.com ]
  end
  
end