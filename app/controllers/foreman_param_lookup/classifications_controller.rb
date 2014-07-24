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
      when 'name', 'host', 'fqdn'
        host = Host.find_by_certname params[:name]
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      when 'certname'
        host = Host.find_by_certname params[:certname]
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      when 'mac'
        host = Host.find_by_mac params[:mac]
        ppclasses = host.puppetclasses + host.hostgroup.puppetclasses
        output(host, ppclasses)
      else
        render :text => "Valid search keys: name, host, fqdn, certname, mac"
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
