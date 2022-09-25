function fn() {
  var env = karate.env; // get java system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev'; // a custom 'intelligent' default
  }
  var config = { // base config JSON
    appId: 'my.app.id',
    appSecret: 'my.secret',
    TflBaseUrl: 'https://api.tfl.gov.uk/journey/journeyresults',
    WikiBaseUrl: 'https://test.wikipedia.org/w/api.php'
  };

  if (env == 'stage') {
    // over-ride only those that need to be
    config.TflBaseUrl = 'https://stage.api.tfl.gov.uk/journey/journeyresults',
    config.WikiBaseUrl = 'https://stage.test.wikipedia.org/w/api.php'
  } else if (env == 'e2e') {
    config.TflBaseUrl = 'https://e2e.api.tfl.gov.uk/journey/journeyresults',
    config.WikiBaseUrl = 'https://e2e.test.wikipedia.org/w/api.php'
  }

//  karate.configure('connectTimeout', 5000);
//  karate.configure('readTimeout', 5000);

  karate.log('karate.env =', karate.env);
  karate.log('config.baseUrl =', config.baseUrl);

  return config;
}