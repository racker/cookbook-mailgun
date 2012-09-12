define :mailgun_message, :to => nil, :from => nil, :subject => nil, :body => nil do

  include_recipe "mailgun"
  include_recipe "chef_handler"
  dbag = Chef::EncryptedDataBagItem.load("mailgun", "mailgun")
  login = dbag['login']
  password = dbag['password']
  params[:to] ||= node[:mailgun][:to]
  params[:from] ||= node[:mailgun][:from]
  params[:subject] ||= "#{node['hostname']}: #{params[:name]}"
  params[:body] ||= params[:subject]

  node.run_state[:messages] ||= []

  if node.run_state[:messages].length == 0 and !login.nil? and !password.nil?
    chef_handler "Mailgun::Mailgun_Sender" do
      source "#{node['chef_handler']['handler_path']}/mailgun_sender.rb"
      arguments [node.run_state[:messages], login, password]
      action :enable
    end
  end

  node.run_state[:messages].push({
    :to => params[:to],
    :from => params[:from],
    :subject => params[:subject],
    :body => params[:body]
  })
end
