module EmailVeracity


  class Resolver

    RECORD_NAMES_TO_RESOLVE_MAP = {
      :a => {
        :method => 'address',
        :constant => Resolv::DNS::Resource::IN::A },
      :mx => {
        :method => 'exchange',
        :constant => Resolv::DNS::Resource::IN::MX } }

    def Resolver.get_servers_for(domain_name, options = {})
      Timeout::timeout(Config[:timeout]) do
        get_resources_for(domain_name, options)
      end
     rescue Timeout::Error
      raise DomainResourcesTimeoutError,
        "Timed out while try to resolve #{domain_name}"
    end

    protected
      def Resolver.get_resources_for(domain_name, options = {})
        setup = { :in => :a }.update(options)
        Resolv::DNS.open do |server|
          record_map = RECORD_NAMES_TO_RESOLVE_MAP[setup[:in]]
          resources = server.getresources(domain_name, record_map[:constant])
          resolve_resources_to_servers(resources, record_map[:method])
        end
      end

      def Resolver.resolve_resources_to_servers(resolv_resources, resolv_method)
        resolv_resources.inject([]) do |array, resource|
          array << resource.method(resolv_method).call.to_s.strip
        end.reject_blank_items
      end

  end


end