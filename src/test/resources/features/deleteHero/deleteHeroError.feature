@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence

Feature: Delete hero does not exist

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')

  @id:1 @DeleteHeroDoesNotExist
  Scenario: Get one hero who does not exist
    * def deleteErrorSchema = read('classpath:../data/response_schemas/get/error_schema.json')
    * def imposibleId = -10
    Given url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters/' + imposibleId
    When method DELETE
    Then status 404
    And match response == deleteErrorSchema
    And print response
