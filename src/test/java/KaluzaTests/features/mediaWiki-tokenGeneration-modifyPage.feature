@MediaWiki

Feature: Workflow/request chaining tests for MediaWiki Token generation with modification of the wiki page

# @author sbada
# Generate CSRF token for a given bot-user and edit a wiki page
# POST /w/api.php
# https://www.mediawiki.org/wiki/API:Main_page#API_documentation


# Action: Step 1: GET request to fetch login token [lgtoken]
  Scenario: Token generation
    Given url WikiBaseUrl
    And param action = 'query'
    And param meta = 'tokens'
    And param type = 'login'
    And param format = 'json'
    And headers { content-type : 'application/json; charset=utf-8' }
    When method get
    Then status 200
    And match response contains { "batchcomplete": "" }

# store the token keys from the response
    * def  loginTokenKey = response.query.tokens.logintoken

#  Action: Step 2: POST request to log in. [Log in]
    Given url WikiBaseUrl
    And headers {"host":"test.wikipedia.org","content-type":"application/x-www-form-urlencoded"}
    And form field action = 'login'
    And form field lgname = 'Sbadada@botTester'
    And form field lgpassword = 'chegbj0rjjsvpge212u5064tel7huj9p'
    And form field lgtoken = loginTokenKey
    And form field format = 'json'
    When method post
    Then status 200
    And match response contains {"login":{"result":"Success","lguserid":55189,"lgusername":"Sbadada"}}


# Action: Step 3: GET a CSRF token
    Given url WikiBaseUrl
    And headers { Content-Type: 'application/json; charset=utf-8', Accept: 'application/json'}
    And param action = 'query'
    And param meta = 'tokens'
    And param format = 'json'
    When method get
    Then status 200
    And match response contains { "batchcomplete": "" }

# store the token keys from the response
    * print response
    * def  csrftoken = response.query.tokens.csrftoken


# Util for generating random number and update to filed "text" for new version
    * def getRandomValue = function() {return Math.floor((1000000) * Math.random());}
    * def createNewUUId = getRandomValue()
    * print createNewUUId

# Action: Step 4: Send a POST request, with the CSRF token, to take action on a page
    Given url WikiBaseUrl
    And headers {"host":"test.wikipedia.org","content-type":"application/x-www-form-urlencoded"}
    And form field action = 'edit'
    And form field title = 'Project:Sandbox'
    And form field text = 'Test Edit'+createNewUUId
    And form field token = csrftoken
    And form field format = 'json'
    When method post
    Then status 200
    And match response.edit.result == "Success"
    * print response


    