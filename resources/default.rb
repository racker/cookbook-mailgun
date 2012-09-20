
actions :create, :nothing
attribute :name, :kind_of => String, :name_attribute => true
attribute :data_bag, :kind_of => String, :default => "mailgun"
attribute :to, :kind_of => String, :default => nil
attribute :from, :kind_of => String, :default => nil
attribute :subject, :kind_of => String, :default => node[:fqdn]
attribute :body, :kind_of => String, :default => nil

def initialize(name, run_context=nil)
  super
  @action = :create
end
