@REQ_HU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Create Hero

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @CreationOfNewHero
  Scenario: T-API-HU_01-CA01 Create a hero successfully
    * def requestBody = read('classpath:../data/request_data/creation/creation_successful_body.json')
    * def heroName = "My favorite hero - " + java.util.UUID.randomUUID()
    * set requestBody.name = heroName
    * def creationSuccessfulSchema = read('classpath:../data/response_schemas/creation/creation_successful_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 201
    And match response == creationSuccessfulSchema
    And print response
    * def heroId = response.id

  @id:2 @CreationOfHeroWithMissingData
  Scenario: T-API-HU_01-CA02 Create a hero with missing data
    * def requestBody = read('classpath:../data/request_data/creation/creation_missing_data_body.json')
    * def creationMissingDataSchema = read('classpath:../data/response_schemas/creation/creation_missing_data_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 400
    And match response == creationMissingDataSchema
    And print response

  @id:1 @CreationOfExistingHero
  Scenario: T-API-HU_01-CA03 Create an existing hero
    # To Create an hero first
    * callonce read('createHero.feature@CreationOfNewHero')
    * def requestBody = read('classpath:../data/request_data/creation/creation_successful_body.json')
    * set requestBody.name = heroName
    * def creationErrorSchema = read('classpath:../data/response_schemas/creation/creation_error_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 400
    And match response == creationErrorSchema
    And print response
