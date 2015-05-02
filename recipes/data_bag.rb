#
# Cookbook Name:: user_ssh
# Recipe:: data_bag
#
# Copyright (c) 2013-2015 Tnarik Innael
# Copyright (c) 2011, Fletcher Nichol
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

bag = node['user']['data_bag_name']

# Fetch the user array from the node's attribute hash. If a subhash is
# desired (ex. node['base']['user_accounts']), then set:
#
#     node['user']['user_array_node_attr'] = "base/user_accounts"
user_array = node
node['user']['user_array_node_attr'].split("/").each do |hash_key|
  user_array = user_array.send(:[], hash_key)
end

groups = {}

# only manage the subset of users defined
((user_array.size == 1 && user_array[0] == "*" ) ? data_bag(bag) : Array(user_array)).each do |i|
  u = data_bag_item(bag, i.gsub(/[.]/, '-'))
  username = u['username'] || u['id']

  unless u['groups'].nil? || u['action'] == 'remove'
    u['groups'].each do |groupname|
      groups[groupname] = [] unless groups[groupname]
      groups[groupname] += [username]
    end
  end
end

groups.each do |groupname, users|
  group "#{groupname}_empty" do
   group_name groupname
    action :create
  end
end

# only manage the subset of users defined
((user_array.size == 1 && user_array[0] == "*" ) ? data_bag(bag) : Array(user_array)).each do |i|
  u = data_bag_item(bag, i.gsub(/[.]/, '-'))
  username = u['username'] || u['id']

  user_ssh_account username do
    %w{comment uid gid home shell password system_user manage_home create_group
        ssh_keys ssh_keygen non_unique}.each do |attr|
      send(attr, u[attr]) if u[attr]
    end
    action Array(u['action']).map { |a| a.to_sym } if u['action']
  end

#  ssh_config "test" do
#    options ({
#        User: 'this _user',
#        Hostname: 'that hostname',
#        IdentityFile: '/var/apps/somerandomkey',
#        LocalForward: 'asomthing',
#        Compression: 'yes'
#    })
#    user username
#    action :add
#  end

end

groups.each do |groupname, users|
  group "#{groupname}_users" do
    group_name groupname
    members users
    append true
    action :manage
  end
end
