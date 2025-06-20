@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Update hero successfully

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @UpdateHeroDoesNotExist
  Scenario: Update hero successfully
    * def updateErrorSchema = read('classpath:../data/response_schemas/update/update_error_schema.json')
    * def requestBody = read('classpath:../data/request_data/update/update_successful_body.json')
    * def imposibleId = -10
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + imposibleId
    And request requestBody
    When method PUT
    Then status 404
    And match response == updateErrorSchema
    And print response
