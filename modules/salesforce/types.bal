# Account type representing a Salesforce Account object
public type Account record {|
    # Name of the Account
    string Name;
    # Type of the Account
    string Type;
    # Currency ISO Code of the Account
    string CurrencyIsoCode;
    # Phone number of the Account
    string? Phone = ();
    # Billing Street of the Account
    string? BillingStreet = ();
    # Billing City of the Account
    string? BillingCity = ();
    # Billing State of the Account
    string? BillingState = ();
    # Billing Postal Code of the Account
    string? BillingPostalCode = ();
    # Billing Country of the Account
    string? BillingCountry = ();
    # Billing Contact Name custom field
    string? Billing_Contact_Name__c = ();
    # Business Contact Email custom field
    string? Business_Contact_Email__c = ();
    json...;
|};
