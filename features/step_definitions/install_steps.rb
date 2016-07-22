require 'open3'
require_relative 'vars'

When(/^I update apt cache$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.lamp.yml --tags 'provision'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

When(/^I install Apache$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.lamp.yml --tags 'apache_setup'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

And(/^Apache should be running$/) do
	cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'sudo service apache2 status'"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
  expect(output).to match("apache2 is running")
end

And(/^it should be accepting connections on port ([^"]*)$/) do |port|
  output, error, status = Open3.capture3 "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'curl -f http://localhost:#{port}'"
  expect(status.success?).to eq(true)
end

When(/^I install MySQL$/) do
	cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.lamp.yml --tags 'mysql_setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^MySQL should be running$/) do
	cmd = "ssh -i '#{PATHTOKEY}' #{AWSPUBDNS} 'sudo service mysql status'"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
	expect(output).to match("mysql start/running")
end

When(/^I install PHP$/) do
	cmd = "ansible-playbook -i inventory.ini --private-key=#{PATHTOKEY} playbook.lamp.yml --tags 'php_setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

