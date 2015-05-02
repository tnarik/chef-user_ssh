#
# Cookbook Name:: user_ssh
# Provider:: account
#
# Copyright (c) 2015 Tnarik Innael
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'etc'

class Chef
  class Provider::UserSshAccount <  Provider::UserAccount
    def load_current_resource
      super
      # Here we keep the existing version of the resource
      # if none exists we create a new one from the resource we defined earlier
      @current_resource ||= Resource::UserSshAccount.new( new_resource.name )
      begin
        pwnam = Etc.getpwnam(current_resource.username)
      rescue ArgumentError => e
        pwnam = nil
      end
      @home_passwd = pwnam.nil? ? nil : pwnam.dir
      #@current_resource.home(pwnam.nil? ? nil : "/export"+::File.realpath(pwnam.dir) )

      # New resource represents the chef DSL block that is being run (from a recipe for example)
      @home_passwd_new = user_home_passwd( @current_resource.username )

      # Although you can reference @new_resource throughout the provider it is best to
      # only make modifications to the current version
      @current_resource
    end

    def action_create
      # If home_passwd matches the expected one, preset new_resource to provide idempotency
      if @home_passwd ==  @home_passwd_new then
        # There is no need to create the folder now
        new_resource.home ( @home_passwd_new )
        @my_home = new_resource.home
      end

      super

      if !@home_passwd_new.nil? and
          @home_passwd_new != new_resource.home then
        # Trigger the user_resource again with an updated home (not managed)
        # This should the entry in the /etc/passwd file
        @my_home = @home_passwd_new
        @manage_home = false
        user_resource(:manage)
      end
    end

    private
    def user_home_passwd(username)
      node['user']['home_passwd_root'].nil? ? nil : "#{node['user']['home_passwd_root']}/#{username}"
    end
  end
end