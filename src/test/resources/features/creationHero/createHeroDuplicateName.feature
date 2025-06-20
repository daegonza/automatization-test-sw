@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Create hero with duplicate name

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @CreationOfExistingHero
  Scenario: Create an existing hero
    # To Create an hero first
    * callonce read('createHeroSuccessfully.feature@CreationOfNewHero')
    * def requestBody = read('classpath:../data/request_data/creation/creation_successful_body.json')
    * set requestBody.name = heroName
    * def creationErrorSchema = read('classpath:../data/response_schemas/creation/creation_error_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 400
    And match response == creationErrorSchema
    And print response
