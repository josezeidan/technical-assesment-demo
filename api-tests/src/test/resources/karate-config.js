function fn() {
    var env = karate.env;
    karate.log('karate.env =', env);

    if (!env) {
        env = 'qa';
    }

    var config = { env: env};

    // Obtain auth token once for the entire suite
    var authResult = karate.callSingle('classpath:com/example/api/features/auth.feature');
    config.authToken = authResult.token;

    return config;
}
