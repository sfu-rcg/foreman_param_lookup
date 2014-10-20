module ForemanParamLookup
  class ClassificationsController < ::ApplicationController

    def lookup
      case params.keys.first
      when 'fqdn'
        host = Host.find_by_name params[:fqdn]
        output host, params[:fqdn]
      when 'clientcert'
        host = Host.find_by_certname params[:clientcert]
        if host.nil?
          host = Host.find_by_name params[:clientcert]
          # Be safe, return nil if we found a host with a maching name, but its
          # certname value isn't nil
          # The .certname method in Host::Managed is being overriden
          # to a return a host's hostname if its certname is nil
          host = nil unless host.send(:read_attribute, :certname) == nil
        end
        output host, params[:clientcert]
      when 'macaddress'
        host = Host.find_by_mac params[:macaddress]
        output host, params[:macaddress]
      else
        render :text => "Valid search keys: fqdn, clientcert, macaddress", :status => 400
      end
    end

    private
      def output(host, lookup)
        return render :text => "No host was returned for #{lookup}", :status => 404 if host.nil?
        render :text => Classification::ClassParam.new(:host => host).enc.to_yaml
      end
  end
end
