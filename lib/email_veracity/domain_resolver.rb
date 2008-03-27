module EmailVeracity
  
  
  class DomainResolver
    
    RECORD_NAMES_TO_RESOLV_MAP = {
      :a => {
        :method => :address,
        :constant => Resolv::DNS::Resource::IN::A },
      :mx => {
        :method => :exchange,
        :constant => Resolv::DNS::Resource::IN::MX }
    }
    @@resolver = Resolv::DNS.new
    
    def self.record_name_to_resolv_method(record_name)
      RECORD_NAMES_TO_RESOLV_MAP[record_name][:method]
    end
    
    def self.record_name_to_resolv_constant(record_name)
      RECORD_NAMES_TO_RESOLV_MAP[record_name][:constant]
    end
    
    def self.get_servers_for(domain_name, options = {})
      setup = { :in => :a }.update(options)
      st = Timeout::timeout(Config.options[:timeout]) do
        resolv_constant = record_name_to_resolv_constant(setup[:in])
        resolv_method = record_name_to_resolv_method(setup[:in])
        resources = @@resolver.getresources(domain_name, resolv_constant)
        resources_to_servers(resources, resolv_method)
      end
    end
    
    protected
      def self.resources_to_servers(resolv_resources, resolv_method)
        resolv_resources.inject([]) do |array, resource|
          array << resource.method(resolv_method).call.to_s.strip
        end.reject_blank_items
      end
      
  end
  
  
end