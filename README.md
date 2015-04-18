# user_ssh cookbook

[![Build Status](https://secure.travis-ci.org/tnarik/chef-user_ssh.png)](http://travis-ci.org/tnarik/chef-user_ssh)

# Description

This cookbook extends the `user_account` LWRP from [fnichol/chef-user](https://github.com/fnichol/chef-user) to support modification of the home folder after creation of the account.

This allows for the creation of the user account in a specific folder and later modification of the corresponding `/etc/passwd` record. This way some Solaris setups (with `auto_home`, for instance) work out of the box.

In addition, a modified version of the `data_bat` recipe is provided, to allow for the use of a wildcard when specifying the list of users (this will trigger the creation of **all** users in data bags) and creation of groups in two stages (first creation, then addition of users to groups).

# Requirements

# Usage

Simply include this cookbook as a dependency in `metadata.rb` and the `user_ssh_account` resource will be available.

To use `recipe[user_ssh::data_bag]`, follow the same approach as for the [fnichol/chef-user](https://github.com/fnichol/chef-user) recipe.

    librarian-chef install

# Attributes

To generate the value for the password, you can use:

    openssl passwd -1 "theplaintextpassword"


# Recipes


# Author

Author :: [Tnarik Innael](tnarik@lecafeautomatique.co.uk)

Author (Original data_bag recipe) :: [Fletcher Nichol](fnichol@nichol.ca) [![endorse](http://api.coderwall.com/fnichol/endorsecount.png)](http://coderwall.com/fnichol)

## Based on

The `data_bag` recipe from [fnichol/chef-user](https://github.com/fnichol/chef-user).

Copyright 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.




[repo]:         https://github.com/fnichol/chef-user
[issues]:       https://github.com/fnichol/chef-user/issues
