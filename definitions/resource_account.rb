#
# Cookbook Name:: user_ssh
# Resource:: account
#
# Copyright (c) 2015 Tnarik Innael
#
# All rights reserved - Do Not Redistribute
#

class Chef
  class Resource::UserSshAccount < Resource::UserAccount
    self.resource_name = :user_ssh_account
#    self.provider = Provider::UserSshAccount

    attribute :home_passwd, kind_of: [String, NilClass], default: nil
    ## Additional attribute
    #@home_passwd = nil
#
    ## Define the attributes we set defaults for
    #def home_passwd(arg=nil)
    #  set_or_return(:home_passwd, arg, :kind_of => [String, NilClass])
    #end
  end
end
