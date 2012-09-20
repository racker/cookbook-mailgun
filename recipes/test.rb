include_recipe "mailgun"
mailgun "test" do
  subject "this is a test from #{node[:fqdn]}"
  to "jordan.evans@rackspace.com"
  body "this is a test"
  action :create
  data_bag "mailgun"
end

file "/tmp/test" do
  content "this is a test"
  notifies :create, "mailgun[test]", :immediately
end
