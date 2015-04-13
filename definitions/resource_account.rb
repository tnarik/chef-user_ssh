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

    attribute :home_passwd, kind_of: [String, NilClass], default: nil
  end
end
