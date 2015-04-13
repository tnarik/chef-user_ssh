#
# Cookbook Name:: user_ssh
# Provider:: account
#
# Copyright (c) 2015 Tnarik Innael
#
# All rights reserved - Do Not Redistribute
#

class Chef
  class Provider::UserSshAccount <  Provider::UserAccount
    def load_current_resource
      super
      # Here we keep the existing version of the resource
      # if none exists we create a new one from the resource we defined earlier
      @current_resource ||= Resource::UserSshAccount.new(new_resource.name)

      # New resource represents the chef DSL block that is being run (from a recipe for example)
      @current_resource.home_passwd(new_resource.home_passwd ||
          "#{node['user']['home_passwd_root']}/#{@current_resource.username}")

      # Although you can reference @new_resource throughout the provider it is best to
      # only make modifications to the current version
      @current_resource
    end

    def action_create
      super

      if @current_resource.home_passwd !=  @current_resource.home then
        # Trigger the user_resource again with an updated home (not managed)
        # This should the entry in the /etc/passwd file
        @my_home = @current_resource.home_passwd
        @manage_home = false
        user_resource(:manage) 
      end
    end
  end
end