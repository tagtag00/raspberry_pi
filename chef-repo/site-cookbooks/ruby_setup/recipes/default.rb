#
# Cookbook Name:: ruby_setup
# Recipe:: default
#
# Copyright 2015, GIC Co.,Ltd.
#
# All rights reserved - Do Not Redistribute
#
case node[:platform_family]
  when "rhel"
    %w[gcc zlib zlib-devel openssl openssl-devel sqlite-devel].each do |pkg|
      package pkg do
        action :install
      end
    end

  when "debian"
    %w[openssl libssl-dev libreadline-dev build-essential curl].each do |pkg|
      package pkg do
        action :install
      end
    end
  end

bash "download ruby-#{node["ruby"]["build"]}" do
  user 'root'
  code <<-EOC
    cd /tmp
    curl -O http://cache.ruby-lang.org/pub/ruby/#{node["ruby"]["family"]}/ruby-#{node["ruby"]["build"]}.tar.gz
  EOC
  not_if { ::File.exists? "/tmp/ruby-#{node["ruby"]["build"]}.tar.gz" }
end

bash "install_ruby" do
  user 'root'
  code <<-EOC
    cd /tmp
    tar xzf ruby-#{node["ruby"]["build"]}.tar.gz
    cd ruby-#{node["ruby"]["build"]}
    ./configure --disable-install-doc
    make
    make install
  EOC

  creates "/usr/local/bin/ruby"
end

# bash "install bundler" do
#   user 'root'
#   code "gem install bundler --no-rdoc --no-ri"
# end

gem_package "bundler" do
  gem_binary "/usr/local/bin/gem"
  options "--no-rdoc --no-ri"
  action :install
end