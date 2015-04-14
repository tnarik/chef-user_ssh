name             'user_ssh'
maintainer       'Tnarik Innael'
maintainer_email 'tnarik@lecafeautomatique.co.uk'
license          'apache2'
description      'A Chef recipe to manage user accounts and SSH keys from databags'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/tnarik/chef-user_ssh'
issues_url       'https://github.com/tnarik/chef-user_ssh/issues'
version          '0.1.0'

%w{user}.each do |cookbook|
  depends cookbook
end

%w{ubuntu debian mac_os_x solaris suse omnios}.each do |os|
  supports os
end

recipe 'user_ssh::data_bag', 'Processes a list of users with data drawn from a data bag.'
