@tfljourney

Feature: TFL journey planner Request, outside London : User wants to plan his journey outside London this weekend

  # @author sbada
  # Perform a Journey Planner search from the parameters specified in simple types
  # /JourneyResults/{from}/to/{to}
  # https://api-portal.tfl.gov.uk/api-details#api=Journey&operation=Journey_JourneyResultsByPathFromPathToQueryViaQueryNationalSearchQueryDateQu

# Positive scenarios
  Scenario Outline: Plan a journey from Point A to Point B (A inside London & B outside London)
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
    And param nationalSearch = <nationalSearch>
    When method get
    Then status 300

    * def responseObject = response
    * def rootKey = 'toLocationDisambiguation'
    * def assertKeys = responseObject[rootKey]
    * match assertKeys.disambiguationOptions[0].$type == "Tfl.Api.Presentation.Entities.JourneyPlanner.DisambiguationOption, Tfl.Api.Presentation.Entities"

    Examples:
      | FROM     | TO             | mode                  | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency | nationalSearch |
      | Victoria | Stonehenge     | 'bus,tube,coach'      | '2022-10-22T13:15:00' | 'Arriving'   | 'LeastTime'        | 'Slow'       | 'Easy'          | 'true'          |
      | Victoria | Windsor Castle | 'tube,coach'          | '2022-11-22T11:15:00' | 'Departing'  | 'LeastInterchange' | 'Average'    | 'Moderate'      | 'true'      |
      | Victoria | Oxford         | 'tube,bus'            | '2022-07-22T10:15:00' | 'Arriving'   | 'LeastWalking'     | 'Fast'       | 'Fast'          | 'true'          |
      | Victoria | Leeds Castle   | 'tube,coach'          | '2022-12-22T13:15:00' | 'Departing'  | 'LeastTime'        | 'Fast'       | 'Fast'          | 'true'          |
      | Victoria | Kew Gardens    | 'coach,national-rail' | '2022-10-22T07:15:00' | 'Arriving'   | 'LeastWalking'     | 'Slow'       | 'Moderate'      | 'true'      |

# Negative scenarios
  Scenario Outline: Plan a journey from Point A to Point B (A inside London & B outside London)
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
    And param nationalSearch = <nationalSearch>
    When method get
    Then status 404

    Examples:
      | FROM     |  TO          | mode                  | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency |nationalSearch |
      |          |              | 'bus,tube,coach'      | '2022-22-22T13:15:00' | 'Arriving'   | 'LeastTime'        | 'Slow'       | 'Easy'          |'true'          |

  Scenario Outline: Plan a journey from Point A to Point B (A inside London & B outside London)
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
    And param nationalSearch = <nationalSearch>
    When method get
    Then status 300

    Examples:
      | FROM     | TO          | mode        | dateTime              | dateTimeType | journeyPreference  | walkingSpeed | bikeProficiency |nationalSearch |
      | Victoria | Canterbury | 'bus'       | '2022-11-45T11:15:00' | 'Departing'  | 'LeastInterchange' | 'Average'    | 'Moderate'      |'true'          |


