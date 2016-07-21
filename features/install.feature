Feature: Configure LAMP stack

	Background: 
		Given I have a running server
		And I provision it

	Scenario:
		When I update apt cache
		Then it should be successful

	Scenario:
		When I install Apache
		Then it should be successful
		And Apache should be running
		And it should be accepting connections on port 80

	Scenario:
		When I install MySQL
		Then it should be successful
		And MySQL should be running
		And it should be accepting connections on port 3306

	Scenario:
		When I install PHP
		Then it should be successful