@tfljourney

Feature: TFL journey planner Request, with disambiguation requests

  # @author sbada
  # Perform a Journey Planner search from the parameters specified in simple types
  # /JourneyResults/{from}/to/{to}
  # https://api-portal.tfl.gov.uk/api-details#api=Journey&operation=Journey_JourneyResultsByPathFromPathToQueryViaQueryNationalSearchQueryDateQu


# Positive scenarios
  Scenario Outline: Disambiguation requests
    Given url TflBaseUrl
    And  path '<FROM>'
    And  path 'to'
    And  path '<TO>'
    And param mode = <mode>
    And param dateTime = <dateTime>
    And param dateTimeType = <dateTimeType>
    And param journeyPreference = <journeyPreference>
    And param walkingSpeed = <walkingSpeed>
    And param bikeProficiency = <bikeProficiency>
    When method get
    Then status 300

    * def responseObject = response
    * def rootKey = 'toLocationDisambiguation'
    * def assertKeys = responseObject[rootKey]
    * match assertKeys.disambiguationOptions[0].$type == "Tfl.Api.Presentation.Entities.JourneyPlanner.DisambiguationOption, Tfl.Api.Presentation.Entities"

    Examples:
      | FROM     | TO          | mode                  | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency |
      | Liverpool Street Station | Kings Cross Station  | 'bus,tube,coach'      | '2022-10-22T13:15:00' | 'Arriving'   | 'LeastTime'        | 'Slow'       | 'Easy'          |
      | Kings Cross Station | Liverpool Street Station | 'tube,coach'          | '2022-11-30T11:15:00' | 'Departing'  | 'LeastInterchange' | 'Average'    | 'Moderate'      |

# Negative scenarios
  Scenario Outline: Disambiguation requests
    Given url TflBaseUrl
    And  path '<FROM>'
    And  path 'to'
    And  path '<TO>'
    And param mode = <mode>
    And param dateTime = <dateTime>
    And param dateTimeType = <dateTimeType>
    And param journeyPreference = <journeyPreference>
    And param walkingSpeed = <walkingSpeed>
    And param bikeProficiency = <bikeProficiency>
    When method get
    Then status 404

    Examples:
      | FROM     |  TO          | mode                  | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency |
      |          |              | 'bus,tube,coach'      | '2022-22-22T13:15:00' | 'Arriving'   | 'LeastTime'        | 'Slow'       | 'Easy'          |


  Scenario Outline: Disambiguation requests
    Given url TflBaseUrl
    And  path '<FROM>'
    And  path 'to'
    And  path '<TO>'
    And param mode = <mode>
    And param dateTime = <dateTime>
    And param dateTimeType = <dateTimeType>
    And param journeyPreference = <journeyPreference>
    And param walkingSpeed = <walkingSpeed>
    And param bikeProficiency = <bikeProficiency>
    When method get
    Then status 300

    Examples:
      | FROM     | TO          | mode        | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency |
      | Victoria | Blackfriars | 'bus'       | '0000-11-22T11:15:00' | 'Departing'  | 'LeastInterchange' | 'Average'    | 'Moderate'      |


