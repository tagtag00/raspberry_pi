#
# Cookbook Name:: wiringPi_install
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

package "git" do
  action :install
end

case node[:platform_family]
  when "rhel"
    %w[gcc zlib zlib-devel openssl openssl-devel sqlite-devel].each do |pkg|
      package pkg do
        action :install
      end
    end

  when "debian"
    %w[openssl libssl-dev libreadline-dev build-essential libi2c-dev].each do |pkg|
      package pkg do
        action :install
      end
    end
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