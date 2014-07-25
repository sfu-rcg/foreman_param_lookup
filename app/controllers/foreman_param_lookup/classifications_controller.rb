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
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      when 'clientcert'
        host = Host.find_by_certname params[:clientcert]
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      when 'macaddress'
        host = Host.find_by_mac params[:macaddress]
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      else
        render :text => "Valid search keys: fqdn, clientcert, macaddress"
      end
    end
    
    private
      def output(host, ppclasses)
        render :text => ForemanParamLookup::AnyClassification.new(
          :host => host, :classes => ppclasses.flatten.compact
        ).enc.to_yaml
      end
  end
end
