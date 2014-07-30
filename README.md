# foreman_param_lookup

Foreman engine plugin that can lookup all assigned class parameters for a host. You can search for hosts by fqdn, certificate name, or MAC address.

# Installation:

Include in your `~foreman/bundler.d/foreman_param_lookup.rb`

    gem 'foreman_param_lookup', :git => "https://github.com/sfu-rcg/foreman_param_lookup.git"

As the Foreman user:

    bundle install

To upgrade to newest version of the plugin:

    bundle update foreman_param_lookup

# Usage

The URL structure requires one of the following parameter keys to be specified: fqdn, clientcert, or macaddress, along with the appropriate value for the host you're trying to find.  

```bash
$ curl http://foreman.domain.com/param_lookup?fqdn=host.example.net
--- 
  module::class: 
    param1: value
    param2: "another value"
    
$ curl http://foreman.domain.com/param_lookup?clientcert=myhostcert.example.net
--- 
  module::class: 
    param1: value
    param2: "another value"
    
$ curl http://foreman.domain.com/param_lookup?macaddress=00:50:56:42:28:n2
--- 
  module::class: 
    param1: value
    param2: "another value"
```

It will return 200 on a successful search, 400 when you use a wrong parameter key, and 404 when a host isn't found.

# Copyright

Original credit & copyright goes to [Dominic Cleal, and Red Hat Inc.](https://github.com/domcleal/foreman_param_lookup), respectively.

Modifications made by Riley Shott in July, 2014.

Copyright (c) 2014 Simon Fraser University

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Copyright (c) 2012-2013 Red Hat Inc.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
