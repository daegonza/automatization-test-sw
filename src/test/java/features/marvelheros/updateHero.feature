@REQ_HU_04 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Update heros

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @UpdateHero
  Scenario: T-API-HU_04-CA01 Update hero successfully
    # To make sure an hero exist
    * callonce read('createHero.feature@CreationOfNewHero')
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

  @id:2 @UpdateHeroMissingData
  Scenario: T-API-HU_04-CA02 Update hero with missing data
    # To make sure an hero exist
    * callonce read('createHero.feature@CreationOfNewHero')
    * def requestBody = read('classpath:../data/request_data/update/update_missing_data_body.json')
    * def updateMissingDataSchema = read('classpath:../data/response_schemas/update/update_missing_data_schema.json')
    * print requestBody
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + heroId
    And request requestBody
    When method PUT
    Then status 400
    And match response == updateMissingDataSchema
    And print response

  @id:1 @UpdateHeroDoesNotExist
  Scenario: T-API-HU_04-CA03 Update hero does not exist
    * def updateErrorSchema = read('classpath:../data/response_schemas/update/update_error_schema.json')
    * def requestBody = read('classpath:../data/request_data/update/update_successful_body.json')
    * def imposibleId = -10
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + imposibleId
    And request requestBody
    When method PUT
    Then status 404
    And match response == updateErrorSchema
    And print response
