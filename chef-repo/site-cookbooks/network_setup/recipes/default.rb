#
# Cookbook Name:: network_setup
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#

template "interfaces" do
	owner "root"
	group "root"
	path "/etc/network/interfaces"
	source "interfaces.erb"
end

template "wpa_supplicant.conf" do
	owner "root"
	group "root"
	path "/etc/wpa_supplicant/wpa_supplicant.conf"
	source "wpa_supplicant.conf.erb"
end

bash "eth0 restart" do
	user "root"
	code "ifdown eth0; ifup eth0"
	action :run
end

bash "wlan0 restart" do
	user "root"
	code "ifdown wlan0; ifup wlan0"
	action :run
end