module EmailVeracity


  class Resolver

    RECORD_NAMES_TO_RESOLV_MAP = {
      :a => {
        :method => 'address',
        :constant => Resolv::DNS::Resource::IN::A },
      :mx => {
        :method => 'exchange',
        :constant => Resolv::DNS::Resource::IN::MX } }

    @@resolver = Resolv::DNS.new

    def self.get_servers_for(domain_name, options = {})
      setup = { :in => :a }.update(options)
      st = Timeout::timeout(Config.options[:timeout]) do
        resolv = RECORD_NAMES_TO_RESOLV_MAP[setup[:in]]
        resources = @@resolver.getresources(domain_name, resolv[:constant])
        resolv_resources_to_servers(resources, resolv[:method])
      end
     rescue Timeout::Error
      raise DomainResourcesTimeoutError,
        "Timed out while try to resolve #{domain_name}"
    end

    protected
      def self.resolv_resources_to_servers(resolv_resources, resolv_method)
        resolv_resources.inject([]) do |array, resource|
          array << resource.method(resolv_method).call.to_s.strip
        end.reject_blank_items
      end

  end


end