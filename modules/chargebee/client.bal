import ballerina/http;

configurable string chargebeeSiteUrl = ?;
configurable string chargebeeApiKey = ?;
configurable string chargebeeApiPassword = ?;

public final http:Client chargebeeClient = check new (chargebeeSiteUrl, {
    auth: {username: chargebeeApiKey, password: chargebeeApiPassword},
    timeout: 60
});
