import ballerinax/salesforce;

public function createAccount(Account account) returns salesforce:CreationResponse|error {
    salesforce:CreationResponse response = check salesforceClient->create("Account", account);
    return response;
}
