Description
===========

The mailgun cookbook installs a mailgun handler which will send an email through mailgun for you.

Requirements
============

It requires a few things:

chef_handler cookbook
an encrypted databag, called 'mailgun', which contains the keys 'login' and 'password'

Attributes
==========

node[:mailgun][:to] = the default to address
node[:mailgun][:from] = the default from address

Usage
=====

mailgun_message "some_message" do
  to 'some_address'
  from 'somewhere_else'
  subject 'example'
  body 'This is an example message'
end

All 4 attributes are not required. If not given, to and from will use the default attributes.
If body is not given, it will be the same as subject.
If subject is not given, it will be the name of the resource ('some_message' in this example).

