@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Delete hero with id

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @DeleteSuccessfullyHero
  Scenario: Delete hero
    # To make sure an hero exist
    * callonce read('../creationHero/createHeroSuccessfully.feature@CreationOfNewHero')
    * def getSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    When method DELETE
    Then status 204
