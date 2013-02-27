@kalibro_restart
Feature: Repository
  As a Mezuro user
  I want to create, edit, remove and process a repository

  Background:
    Given the following users
      | login     | name       |
      | joaosilva | Joao Silva |
    And I am logged in as "joaosilva"
    And "Mezuro" plugin is enabled
    And the following community
      | identifier  | name         |
      | mycommunity | My Community |
    And "Joao Silva" is admin of "My Community"
    And I have a Mezuro project with the following data
      | name        | Sample Project      |
      | description | Sample Description  |
      | community   | mycommunity         |
    And I have a Mezuro configuration with the following data
      | name        | Sample Configuration|
      | description | Sample Description  |
      | user        | joaosilva           |
    And I have a Mezuro reading group with the following data
      | name        | Sample Reading group |
      | description | Sample Description   |
      | user        | joaosilva            |
    And I have a Mezuro metric configuration with previous created configuration and reading group
    And I am on article "Sample Project"

  Scenario: I want to see the Mezuro repository input form
    When I follow "Add Repository"
    Then I should see "Name"
    And I should see "Description"
    And I should see "License"
    And I should see "Process Period"
    And I should see "Type"
    And I should see "Address"
    And I should see "Configuration"
    And I should see "Add" button

  @selenium
  Scenario: I try to add a repository with no name
    Given I follow "Add Repository"
    When I fill the fields with the new following data
      | repository_name               |                                                                 |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | SUBVERSION                                                      |
      | repository_address            | https://project.svn.sourceforge.net/svnroot/project             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    Then I should see "Please fill all fields marked with (*)." inside an alert

  @selenium
  Scenario: I try to add a repository with no address
    Given I follow "Add Repository"
    When I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | SUBVERSION                                                      |
      | repository_address            |                                                                 |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    Then I should see "Please fill all fields marked with (*)." inside an alert

  @selenium
  Scenario: I try to add a repository with a invalid address
    Given I follow "Add Repository"
    When I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://invalid-address.any-extension                           |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    Then I should see "Address does not match type GIT chosen." inside an alert

  @selenium
  Scenario: I want to add a repository with valid attributes
    Given I follow "Add Repository"
    When I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://github.com/user/project.git                             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    Then I should see "My Name"
    And I should see "My Description"
    And I should see "ISC License (ISC)"
    And I should see "Not Periodically"
    And I should see "GIT"
    And I should see "https://github.com/user/project.git"
    And I should see "Sample Configuration"

  #FIXME: create the step given I have repository...    
  @selenium
  Scenario: I want to see the repository edit form
    Given I follow "Add Repository"
    And I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://github.com/user/project.git                             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    And I am on article "Sample Project"
    When I follow "Edit"
    Then I should see "My Name" in the "repository_name" input      
    And I should see "My Description" in the "repository_description" input
    And I should see "ISC License (ISC)" in the "repository_license" select
    And I should see "Not Periodically" in the process period select field
    And I should see "GIT" in the "repository_type" select
    And I should see "https://github.com/user/project.git" in the "repository_address" input
    And I should see "Sample Configuration" in the "repository_configuration_id" select

  #FIXME: create the step given I have repository...    
  @selenium
  Scenario: I want to see the repository edit form
    Given I follow "Add Repository"
    And I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://github.com/user/project.git                             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    And I am on article "Sample Project"
    When I follow "Edit"
    Then I should see "My Name" in the "repository_name" input      
    And I should see "My Description" in the "repository_description" input
    And I should see "ISC License (ISC)" in the "repository_license" select
    And I should see "Not Periodically" in the process period select field
    And I should see "GIT" in the "repository_type" select
    And I should see "https://github.com/user/project.git" in the "repository_address" input
    And I should see "2" in the "repository_configuration_id" select

  #FIXME: create the step given I have repository...  
  @selenium
  Scenario: I try to edit a Mezuro project leaving empty its title
    Given I follow "Add Repository"
    And I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://github.com/user/project.git                             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    And I am on article "Sample Project"   
		And I follow "Edit"
    When I erase the "repository_name" field
    And I press "Add"
    Then I should see "Please fill all fields marked with (*)." inside an alert

  #FIXME: create the step given I have repository...  
  @selenium
  Scenario: I try to edit a Mezuro project leaving empty its address
    Given I follow "Add Repository"
    And I fill the fields with the new following data
      | repository_name               | My Name                                                         |
      | repository_description        | My Description                                                  |
      | repository_license            | ISC License (ISC)                                               |
      | repository_process_period     | Not Periodically                                                |
      | repository_type               | GIT                                                             |
      | repository_address            | https://github.com/user/project.git                             |
      | repository_configuration_id   | Sample Configuration                                            |
    And I press "Add"
    And I am on article "Sample Project"   
		And I follow "Edit"
    When I erase the "repository_address" field
    And I press "Add"
    Then I should see "Please fill all fields marked with (*)." inside an alert
    
