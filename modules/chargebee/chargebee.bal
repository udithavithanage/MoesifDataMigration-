import ballerina/http;

public isolated function fetchInvoices(int 'limit) returns InvoiceRecord[]|error {
    string path = string `${CHARGEBEE_GET_INVOICES_ENDPOINT}?limit=${'limit}`;

    http:Response invoiceRes = check chargebeeClient->get(path);
    if invoiceRes.statusCode != 200 {
        return error("Chargebee API error (invoices): " + invoiceRes.reasonPhrase);
    }

    json payload = check invoiceRes.getJsonPayload();
    InvoiceResponse response = check payload.cloneWithType();
    InvoiceRecord[] invoiceList = response.list;

    return invoiceList;
}

public isolated function fetchCustomers(string[] customerIdArray) returns Customer[]|error {
    string path = string `${CHARGEBEE_GET_CUSTOMERS_ENDPOINT}`;
    Customer[] customers = [];

    foreach string Id in customerIdArray {
        http:Response customerRes = check chargebeeClient->get(path + "/" + Id);
        if customerRes.statusCode != 200 {
            return error("Chargebee API error (customers): " + customerRes.reasonPhrase);
        }

        json payload = check customerRes.getJsonPayload();
        CustomerResponse response = check payload.cloneWithType();
        customers.push(response.customer);
    }

    return customers;
}
