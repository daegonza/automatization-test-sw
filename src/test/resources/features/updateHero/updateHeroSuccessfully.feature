@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Update hero successfully

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @UpdateHero
  Scenario: Update hero successfully
    # To make sure an hero exist
    * callonce read('../creationHero/createHeroSuccessfully.feature@CreationOfNewHero')
    * def requestBody = read('classpath:../data/request_data/update/update_successful_body.json')
    * set requestBody.name = heroName
    * def updateSuccessullySchema = read('classpath:../data/response_schemas/update/update_successful_schema.json')
    * print requestBody
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    And request requestBody
    When method PUT
    Then status 200
    And match response == updateSuccessullySchema
    And print response
