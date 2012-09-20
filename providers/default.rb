action :create do
  node.run_state[:messages] ||= []
  to = @new_resource.to ? @new_resource.to : node[:mailgun][:to]
  from = @new_resource.from ? @new_resource.from : node[:mailgun][:from]

  node.run_state[:messages].push({
    :to => to,
    :from => from,
    :subject => @new_resource.subject,
    :body => @new_resource.body
  })
end

action :nothing do
end
