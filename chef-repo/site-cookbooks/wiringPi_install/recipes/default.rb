#
# Cookbook Name:: wiringPi_install
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

package "git" do
  action :install
end

# wiringPiを落としてくる
git "/tmp/wiringPi" do
  repository "https://github.com/WiringPi/WiringPi.git"
  reference "master"
  action :sync
  user "root"
  group "root"
end

bash "wiringPi build" do
	user "root"
	cwd "/tmp/wiringPi"
	code "./build"
	action :run
end 