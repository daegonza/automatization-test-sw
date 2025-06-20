@REQ_HU_02 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Delete heros

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @DeleteSuccessfullyHero
  Scenario: T-API-HU_02-CA01 Delete a hero successfully
    # To make sure an hero exist
    * callonce read('createHero.feature@CreationOfNewHero')
    * def getSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    When method DELETE
    Then status 204

  @id:2 @DeleteHeroDoesNotExist
  Scenario: T-API-HU_02-CA02 Delete one hero does not exist
    * def deleteErrorSchema = read('classpath:../data/response_schemas/get/error_schema.json')
    * def imposibleId = -10
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + imposibleId
    When method DELETE
    Then status 404
    And match response == deleteErrorSchema
    And print response
