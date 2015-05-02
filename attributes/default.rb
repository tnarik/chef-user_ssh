# Until fnichol/chef-user#92 is fixed, let's override these settings here.
case platform
when 'solaris2'
  default['user']['home_root']        = "/export/home"
  default['user']['home_passwd_root'] = "/home"
  default['user']['default_shell']    = "/bin/bash"
end