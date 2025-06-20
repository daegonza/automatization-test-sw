@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Create hero with duplicate name

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @GetOneHero
  Scenario: Get one hero
    # To make sure an hero exist
    * callonce read('../creationHero/createHeroSuccessfully.feature@CreationOfNewHero')
    * def getSuccessullySchema = read('classpath:../data/response_schemas/get/successfully_schema.json')
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    When method GET
    Then status 200
    And match response == getSuccessullySchema
    And print response
