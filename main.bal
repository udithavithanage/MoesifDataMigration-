import Moesif.chargebee;

import ballerina/io;

public function main() returns error? {
    string[] customerIds = [];
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

        chargebee:Customer[]|error customers = chargebee:fetchCustomers(customerIds);

        if customers is error {
            return error("Failed to fetch customers: " + customers.message());
        }

        io:println("Fetched customers: ", customers);
        break;
    }
}
