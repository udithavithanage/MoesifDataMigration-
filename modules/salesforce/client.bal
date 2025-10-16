import ballerinax/salesforce;

configurable string salesforceBaseUrl = ?;
configurable string salesforceClientId = ?;
configurable string salesforceClientSecret = ?;
configurable string salesforceRefreshToken = ?;
configurable string salesforceRefreshUrl = ?;

salesforce:ConnectionConfig sfConfig = {
    baseUrl: salesforceBaseUrl,
    auth: {
        clientId: salesforceClientId,
        clientSecret: salesforceClientSecret,
        refreshToken: salesforceRefreshToken,
        refreshUrl: salesforceRefreshUrl
    }
};

public final salesforce:Client salesforceClient = check new (sfConfig);
