@REQ_TESTHU_01 @APIMarvelHeros @Agente2 @karate @Telepresence


Feature: Create Hero successfully

  Background:
    * configure ssl = true
    * json user_data = read('classpath:../data/user.json')
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com/' + user_data.user + '/api/characters'

  @id:1 @CreationOfNewHero
  Scenario: Create a hero
    * def requestBody = read('classpath:../data/request_data/creation/creation_successful_body.json')
    * def heroName = "My favorite hero - " + java.util.UUID.randomUUID()
    * set requestBody.name = heroName
    * def creationSuccessfulSchema = read('classpath:../data/response_schemas/creation/creation_successful_schema.json')
    * print requestBody
    And request requestBody
    When method POST
    Then status 201
    And match response == creationSuccessfulSchema
    And print response
    * def heroId = response.id
