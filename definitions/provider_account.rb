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
        @my_home = "#{@current_resource.home_passwd}"
        @manage_home = false
        user_resource(:manage) 

      #  user_resource = Resource::User.new(@current_resource.username)
      #  if user_resource then
      #    user_resource.home("#{@current_resource.home_passwd}")
      #    user_resource.run_action(:manage)
#  
      #    new_resource.updated_by_last_action(true) if r.updated_by_last_action?
      #  else
      #  end
      end
    end

    #def user_resource(exec_action)
    #  super(exec_action)
    #
    #  # Enhance the provider on creation only
    #  case exec_action
    #    when :create
    #    # Modify the home
    #    Chef::Provider::User username do
    #      home "/home/#{username}"
    #      action :manage
    #    end
    #  end
    #end
  end
end