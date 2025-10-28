import Moesif.chargebee;
import Moesif.salesforce;
import Moesif.utils;

import ballerina/io;
import ballerinax/salesforce as sf;

public function main() returns error? {
    string[] customerIds = [];
    while true {
        chargebee:InvoiceRecord[]|error invoiceList = chargebee:fetchInvoices(5);

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

        foreach chargebee:Customer customer in customers {
            salesforce:Account account = {
                Name: customer?.company !is () ? <string>customer?.company : customer.id,
                Type: customer.'object,
                CurrencyIsoCode: customer.preferred_currency_code,
                Phone: customer?.billing_address?.phone,
                BillingStreet: (customer?.billing_address?.line1 !is () ? ", " + <string>customer?.billing_address?.line1 : "") +
                    (customer?.billing_address?.line2 !is () ? ", " + <string>customer?.billing_address?.line2 : "") +
                    (customer?.billing_address?.line3 !is () ? ", " + <string>customer?.billing_address?.line3 : ""),
                BillingCity: customer?.billing_address?.city,
                BillingState: customer?.billing_address?.state,
                BillingPostalCode: customer?.billing_address?.zip,
                BillingCountry: utils:chargebeeIsoToSalesforceName(customer?.billing_address?.country),
                Billing_Contact_Name__c: customer.first_name !is () && customer?.last_name !is () ?
                    <string>customer.first_name + " " + <string>customer?.last_name : (),
                Business_Contact_Email__c: customer.email
            };
            sf:CreationResponse|error response = salesforce:createAccount(account);
            if response is error {
                io:println("Failed to create Salesforce Account for Customer ID ", customer.id, ": ", response.message());
                continue;
            }
            io:println("Created Salesforce Account with ID: ", response);
        }
        break;

    }
}
