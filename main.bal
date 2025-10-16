import Moesif.chargebee;

import ballerina/http;
import ballerina/io;

public function main() returns error? {
    string[] customerIds = [];
    string customerPath = "/api/v2/customers/";
    while true {

        chargebee:InvoiceRecord[]|error invoiceList = chargebee:fetchInvoices(100);

        if invoiceList is error {
            return error("Failed to fetch invoices: " + invoiceList.message());
        }

        if invoiceList.length() == 0 {
            break;
        }

        // Extract unique customer IDs
        foreach chargebee:InvoiceRecord invoiceRecord in invoiceList {
            chargebee:Invoice invoice = invoiceRecord.invoice;
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

        io:println(customerIds, " total unique customers so far: ", customerIds.length());

        foreach string customerId in customerIds {
            http:Response customerRes = check chargebee:chargebeeClient->get(customerPath + customerId);
            if customerRes.statusCode != 200 {
                return error("Chargebee API error (customers): " + customerRes.reasonPhrase);
            }

            json customerPayload = check customerRes.getJsonPayload();
            chargebee:CustomerResponse customerResponse = check customerPayload.cloneWithType();

            io:println("Fetched customer: ", customerResponse.customer);
        }
        break;
    }
}
