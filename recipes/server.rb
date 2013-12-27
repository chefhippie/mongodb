#
# Cookbook Name:: mongodb
# Recipe:: server
#
# Copyright 2013, Thomas Boerger
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
  include_recipe "apt"

  apt_repository "mongodb" do
    uri node["mongodb"]["apt"]["uri"]
    distribution node["mongodb"]["apt"]["distribution"]
    components node["mongodb"]["apt"]["components"]
    keyserver node["mongodb"]["apt"]["keyserver"]
    key node["mongodb"]["apt"]["key"]
    source node["mongodb"]["apt"]["source"]

    action :add
  end
when "ubuntu"
  include_recipe "apt"

  apt_repository "mongodb" do
    uri node["mongodb"]["apt"]["uri"]
    distribution node["mongodb"]["apt"]["distribution"]
    components node["mongodb"]["apt"]["components"]
    keyserver node["mongodb"]["apt"]["keyserver"]
    key node["mongodb"]["apt"]["key"]
    source node["mongodb"]["apt"]["source"]

    action :add
  end
when "suse"
  include_recipe "zypper"

  zypper_repository node["redis"]["zypper"]["alias"] do
    uri node["redis"]["zypper"]["repo"]
    key node["redis"]["zypper"]["key"]
    title node["redis"]["zypper"]["title"]

    action :add
  end
end

node["mongodb"]["server"]["packages"].each do |name|
  package name do
    action :install
  end
end

service "mongodb" do
  service_name node["mongodb"]["server"]["service_name"]
  action [:enable, :start]
end
