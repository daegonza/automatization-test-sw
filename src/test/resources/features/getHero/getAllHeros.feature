@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Create hero with duplicate name

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @GetAllHeros
  Scenario: Get all heros
    # To make sure an hero exist
    * callonce read('../creationHero/createHeroSuccessfully.feature@CreationOfNewHero')
    * def getAllSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    When method GET
    Then status 200
    And match response[0] == getAllSuccessullySchema
    And print response
