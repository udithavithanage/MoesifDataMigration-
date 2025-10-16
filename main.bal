import Moesif.chargebee;

// import Moesif.salesforce as sf;

import ballerina/http;
import ballerina/io;

// import ballerinax/salesforce;

public function main() returns error? {
    string[] customerIds = [];
    string? offset = ();
    int 'limit = 3;
    string path = string `/api/v2/invoices?limit=${'limit}`;
    if offset is string {
        path += "&offset=" + offset;
    }
    while true {

        http:Response res = check chargebee:chargebeeClient->get(path);
        if res.statusCode != 200 {
            return error("Chargebee API error (invoices): " + res.reasonPhrase);
        }

        json payload = check res.getJsonPayload();
        InvoiceResponse payloadTyped = check payload.cloneWithType();
        io:println(payloadTyped);

        //     json[] invoiceList = check payload.list.ensureType();

        //     if invoiceList.length() == 0 {
        //         break;
        //     }

        //     // Extract unique customer IDs
        //     foreach json item in invoiceList {
        //         json invoice = check item.invoice;
        //         string customerId = check invoice.customer_id;
        //         boolean exists = false;
        //         foreach string id in customerIds {
        //             if id == customerId {
        //                 exists = true;
        //                 break;
        //             }
        //         }
        //         if !exists {
        //             customerIds.push(customerId);
        //         }
        //     }

        //     // Update offset for next page
        //     offset = payload.next_offset is json ? check payload.next_offset : ();
        // }

        // // Migrate customers with invoices to Salesforce
        // int totalMigrated = 0;
        // foreach string customerId in customerIds {
        //     // Fetch customer details
        //     http:Response res = check chargebee:chargebeeClient->get("/api/v2/customers/" + customerId);
        //     if res.statusCode != 200 {
        //         io:println("Failed to fetch customer " + customerId + ": " + res.reasonPhrase);
        //         continue;
        //     }

        //     json customer = check (check res.getJsonPayload()).customer;

        //     // Map fields (same as original)
        //     json|error? firstName = customer.first_name is string ? customer.first_name : "";
        //     string lastName = customer.last_name is string ? customer.last_name : "";
        //     string name = (firstName + " " + lastName).trim();
        //     if name == "" {
        //         name = customer.company is string ? customer.company : "Unknown Customer";
        //     }
        //     string email = customer.email is string ? customer.email : "";
        //     string phone = customer.phone is string ? customer.phone : "";
        //     string createdAt = customer.created_at is int ? customer.created_at.toString() : "";

        //     record {| anydata...; |} accountRecord = {
        //         "Name": name,
        //         "Email__c": email,
        //         "Phone": phone,
        //         "Description": "Migrated from Chargebee. Original ID: " + customerId + ". Created at: " + createdAt
        //     };

        //     // Insert into Salesforce
        //     do {
        //         salesforce:CreationResponse sfResponse = check sf:salesforceClient->create("Account", accountRecord);
        //         io:println("Migrated Chargebee customer " + customerId + " to Salesforce Account ID: " + sfResponse.id);
        //         totalMigrated += 1;
        //     } on fail error e {
        //         io:println("Failed to migrate customer " + customerId + ": " + e.message());
        //     }
        // }

        // io:println("Migration complete. Total records migrated: " + totalMigrated.toString());
        break;
    }
}
