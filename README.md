# Kaluza Test Suits with Karate
This project is an automation testing framework primarily focussed on API testing on TFL endpoint[API] and MediaWiki[workflow]

I have used [Karate](https://www.karatelabs.io/) an open-source tool to combine API test-automation, performance-testing into a single, unified framework.The BDD syntax popularized by Cucumber.

Avoided TestNg, RestAssured, Cypress frameworks as they are code-heavy while Karate saved 37% of developers productivity.

### Rational
* Re-useability, low code
* Data-driven and variability
* Parallel execution (default 5 threads) to faster execution time
* Enviornment agnostic (DEV, QA, Perf, Prod)
* Build-in reporting engine (cucumber)
* Extend standalone Integration tests to Performance-tests

## Tech Stack
Java 1.8, Maven, Karate

## Installation
### Prerequisite
* Java 1.8 or later
* Apache Maven 3.8
* Karate Core 1.3 or later

## Setting up Locally
Git clone this repo
```bash
  git clone https://github.com/joinsbada/KaluzaTestSuits.git
```

Run this command from the project dir
```bash
  mvn clean install
```


## Running Tests
#### Grouping modes for running tests:
Only TFL API Tests, then run the following  command
```bash
mvn test "-Dkarate.options=--tags @tfljourney"
```
Only Media Wiki Api Tests, then run the following command
```bash
mvn test "-Dkarate.options=--tags @MediaWiki"
```
Run all tests
```bash
mvn clean install
```

## Cucumber Test Report
Detailed [Cucumber test report](https://github.com/joinsbada/KaluzaTestSuits/blob/main/target/karate-reports.zip) under /target/karate-reports/karate-summary.html folder, which will be auto created once you run the test from command line.

![Report sample](https://github.com/joinsbada/KaluzaTestSuits/blob/main/target/Screenshot%202022-09-25%20at%202.02.33%20AM.png)


## Environment Variables
The runtime is configured to use 2 config properties and defaulting to "dev" as test enviornment
```bash
TflBaseUrl: 'https://api.tfl.gov.uk/journey/journeyresults' 
WikiBaseUrl: 'https://test.wikipedia.org/w/api.php'
```

## Switching Test Environments
Its quite common we come across to run same tests across test enviornments to see the change in delta (code behaviour, response object change or response time) karate-config.js file provides that capability to agnostic switch env when needed.

Run Tests on stage env, with different endpoint matching stage
```bash
mvn test -DargLine="-Dkarate.env=stage"
```
Run Tests on e2e env, with different endpoint matching e2e
```bash
mvn test -DargLine="-Dkarate.env=e2e"
```

### Jenkins Pipeline
Created a [jenkins pipeline](https://github.com/joinsbada/KaluzaTestSuits/blob/main/Jenkinsfile) stage flow for build, deploy, tests

### GitHub Actions
Created yml to listen to events  contineous runs [Github Actions] (https://github.com/joinsbada/KaluzaTestSuits/actions/runs/3123619449/jobs/5066407599) check outs the main master branch, builds on ubuntu-latest with Java 8 SDK, packages it and Upload karate cucumber report onto artifacts. 


## Future works
* Response object for TFLs API is quite large >800KB in size due to multiselect, response object need to be stored locally to match specific response keys/value to improve time on test runs instead of iteration
* Code can be better modularized and chunked from reusability standpoint
* The API's request payload can be externalized instead of having onto .feature file
* TFLs JourneyPlanner API can be data-driven via Excel sheet for larger variability of travel plans
* User auth for WikiBaseUrl like username/passwords can be externalized or replaced with a secret storage services like Password manager applications like OpenID or SSO
* MediaWiki workflow/chaining of requests are quit common usecases, instead of "replace" action in the request payload we can externalize via .json file
* MediaWiki tests will fail sometimes due to on-going maintenance, therefore asserted only the http status code




