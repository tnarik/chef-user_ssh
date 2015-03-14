name             "user_ssh"
maintainer       "Tnarik Innael"
maintainer_email "tnarik@lecafeautomatique.co.uk"
license          "Apache 2.0"
description      "A Chef recipe to manage user accounts and SSH keys from databags"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ubuntu debian mac_os_x suse omnios}.each do |os|
  supports os
end

%w{user}.each do |cookbook|
  depends cookbook
end

recipe "user_ssh::data_bag", "Processes a list of users with data drawn from a data bag."
