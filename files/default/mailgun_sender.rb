require 'rubygems'
require 'pony'

module Mailgun
  class Mailgun_Sender < Chef::Handler

    def initialize(login, password)
      @login = login
      @password = password
    end

    def report
      node.run_state[:messages] ||= []
      node.run_state[:messages].each do |message|
        Pony.mail({
          :to => message[:to],
          :subject => message[:subject],
          :from => message[:from],
          :body => message[:body],
          :via => :smtp,
          :via_options => {
            :address => 'smtp.mailgun.org',
            :port => 587,
            :enable_starttls_auto => true,
            :user_name => @login,
            :password => @password,
            :authentication => :plain
          }
        })
      end
    end
  end
end
