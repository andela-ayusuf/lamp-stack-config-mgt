require 'open3'

Given(/^I have a running server$/) do
  output, error, status = Open3.capture3 "vagrant reload"
  expect(status.success?).to eq(true)
end

And(/^I provision it$/) do
	output, error, status = Open3.capture3 "vagrant provision"
	cmd = "ansible-playbook -i inventory.ini --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant playbook.provision.yml --tags 'provision'"
	provision_output, provision_error, provision_status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
	expect(provision_status.success?).to eq(true)
end

When(/^I install Apache$/) do
  cmd = "ansible-playbook -i inventory.ini --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant playbook.lamp.yml --tags 'apache_setup'"
  output, error, @status = Open3.capture3 "#{cmd}"
end

Then(/^it should be successful$/) do
  expect(@status.success?).to eq(true)
end

And(/^Apache should be running$/) do
	cmd = "vagrant ssh -c 'sudo service apache2 status'"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
  expect(output).to match("apache2 is running")
end

And(/^it should be accepting connections on port ([^"]*)$/) do |port|
  output, error, status = Open3.capture3 "vagrant ssh -c 'curl -f http://localhost:#{port}'"
  expect(status.success?).to eq(true)
end

When(/^I install MySQL$/) do
	cmd = "ansible-playbook -i inventory.ini --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant playbook.lamp.yml --tags 'mysql_setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

And(/^MySQL should be running$/) do
	cmd = "vagrant ssh -c 'sudo service mysql status'"
	output, error, status = Open3.capture3 "#{cmd}"
	expect(status.success?).to eq(true)
	expect(output).to match("mysql start/running")
end

When(/^I install PHP$/) do
	cmd = "ansible-playbook -i inventory.ini --private-key=.vagrant/machines/default/virtualbox/private_key -u vagrant playbook.lamp.yml --tags 'php_setup'"
	output, error, @status = Open3.capture3 "#{cmd}"
end

