module ForemanParamLookup
  class ClassificationsController < ::ApplicationController
    skip_before_filter :require_login, :only => :lookup
    skip_before_filter :require_ssl, :only => :lookup
    skip_before_filter :authorize, :only => :lookup
    skip_before_filter :set_taxonomy, :only => :lookup
    skip_before_filter :session_expiry, :update_activity_time, :only => :lookup
    before_filter :set_admin_user, :only => :lookup

    def lookup
      case params.keys.first
      when 'fqdn'
        host = Host.find_by_name params[:fqdn]
        output host, params[:fqdn]
      when 'clientcert'
        host = Host.find_by_certname params[:clientcert]
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
