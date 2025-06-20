@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Create hero with missing data

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @CreationOfHeroWithMissingData
  Scenario: Create an hero with missing data
    * def requestBody = read('classpath:../data/request_data/creation/creation_missing_data_body.json')
    * def creationMissingDataSchema = read('classpath:../data/response_schemas/creation/creation_missing_data_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 400
    And match response == creationMissingDataSchema
    And print response
