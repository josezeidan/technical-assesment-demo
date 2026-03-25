function fn() {
    var env = karate.env;
    karate.log('karate.env =', env);

    if (!env) {
        env = 'qa';
    }

    var envConfig = karate.call('classpath:karate-config-' + env + '.js');

    var config = {
        env: env,
        baseUrl: envConfig.baseUrl
    };

    var authResult = karate.callSingle('classpath:com/example/api/features/auth.feature');
    config.authToken = authResult.token;

    return config;
}
