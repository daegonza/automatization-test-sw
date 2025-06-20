@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Update hero successfully

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @UpdateHeroMissingData
  Scenario: Update hero successfully
    # To make sure an hero exist
    * callonce read('../creationHero/createHeroSuccessfully.feature@CreationOfNewHero')
    * def requestBody = read('classpath:../data/request_data/update/update_missing_data_body.json')
    * def updateMissingDataSchema = read('classpath:../data/response_schemas/update/update_missing_data_schema.json')
    * print requestBody
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    And request requestBody
    When method PUT
    Then status 400
    And match response == updateMissingDataSchema
    And print response
