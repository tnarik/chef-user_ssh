#
# Cookbook Name:: user_ssh
# Resource:: account
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

class Chef
  class Resource::UserSshAccount < Resource::UserAccount
    self.resource_name = :user_ssh_account

    attribute :home_passwd, kind_of: [String, NilClass], default: nil
  end
end
