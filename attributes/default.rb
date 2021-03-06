#
# Cookbook Name:: mongodb
# Attributes:: default
#
# Copyright 2013-2014, Thomas Boerger <thomas@webhippie.de>
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

case node["platform_family"]
when "debian"
when "suse"
  repo = case node["platform_version"]
  when /\A13\.\d+\z/
    "openSUSE_#{node["platform_version"]}"
  when /\A42\.\d+\z/
    "openSUSE_Leap_#{node["platform_version"]}"
  when /\A\d{8}\z/
    "openSUSE_Tumbleweed"
  else
    raise "Unsupported SUSE version"
  end

  default["mongodb"]["zypper"]["alias"] = "server-database"
  default["mongodb"]["zypper"]["title"] = "Server Database"
  default["mongodb"]["zypper"]["repo"] = "http://download.opensuse.org/repositories/server:/database/#{repo}/"
  default["mongodb"]["zypper"]["key"] = "#{node["mongodb"]["zypper"]["repo"]}repodata/repomd.xml.key"
when "debian"
  case node["platform"]
  when "debian"
    default["mongodb"]["apt"]["uri"] = "http://downloads-distro.mongodb.org/repo/debian-sysvinit"
    default["mongodb"]["apt"]["distribution"] = "dist"
    default["mongodb"]["apt"]["components"] = %w(10gen)
    default["mongodb"]["apt"]["keyserver"] = "keyserver.ubuntu.com"
    default["mongodb"]["apt"]["key"] = "7F0CEB10"
    default["mongodb"]["apt"]["source"] = false
  when "ubuntu"
    default["mongodb"]["apt"]["uri"] = "http://downloads-distro.mongodb.org/repo/ubuntu-upstart"
    default["mongodb"]["apt"]["distribution"] = "dist"
    default["mongodb"]["apt"]["components"] = %w(10gen)
    default["mongodb"]["apt"]["keyserver"] = "keyserver.ubuntu.com"
    default["mongodb"]["apt"]["key"] = "7F0CEB10"
    default["mongodb"]["apt"]["source"] = false
  end
end
