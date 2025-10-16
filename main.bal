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
        InvoiceResponse response = check payload.cloneWithType();

        InvoiceRecord[] invoiceList = response.list;

        if invoiceList.length() == 0 {
            break;
        }

        // Extract unique customer IDs
        foreach InvoiceRecord invoiceRecord in invoiceList {
            Invoice invoice = invoiceRecord.invoice;
            string customerId = invoice.customer_id;
            boolean exists = false;
            foreach string id in customerIds {
                if id == customerId {
                    exists = true;
                    break;
                }
            }
            if !exists {
                customerIds.push(customerId);
            }
        }

        io:println(customerIds);

        break;
    }
}
