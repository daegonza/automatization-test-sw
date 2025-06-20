@REQ_HU_03 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Get heros

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @GetAllHeros
  Scenario: T-API-HU_03-CA01 Get all heros
    # To make sure an hero exist
    * callonce read('createHero.feature@CreationOfNewHero')
    * def getAllSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    When method GET
    Then status 200
    And match response[0] == getAllSuccessullySchema
    And print response

  @id:2 @GetOneHero
  Scenario: T-API-HU_03-CA02 Get one hero
    # To make sure an hero exist
    * callonce read('createHero.feature@CreationOfNewHero')
    * def getSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    When method GET
    Then status 200
    And match response == getSuccessullySchema
    And print response

  @id:3 @GetHeroDoesNotExist
  Scenario: T-API-HU_03-CA03 Get one hero does not exist
    * def getErrorSchema = read('classpath:../data/response_schemas/get/error_schema.json')
    * def imposibleId = -10
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + imposibleId
    When method GET
    Then status 404
    And match response == getErrorSchema
    And print response
