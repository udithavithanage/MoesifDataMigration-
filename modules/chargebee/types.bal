public type InvoiceRecord record {|
    # Invoice
    Invoice invoice;
|};

public type InvoiceResponse record {|
    # List of Invoices
    InvoiceRecord[] list;
    # Offset for next set of results
    string? next_offset;
|};

public type Invoice record {|
    # Id of the invoice
    string id;
    # Id of the customer
    string customer_id;
    # Subscription id
    string subscription_id?;
    # Status of the invoice
    string status;
    # Date of the invoice
    int date;
    # Total amount of the invoice
    int total;
    # Paid amount of the invoice
    int amount_paid;
    # Paisd at timestamp
    int paid_at?;
    # Currency code
    string currency_code;
    # Billing address of the invoice
    BillingAddress? billing_address;
    # Line items in the invoice
    LineItem[] line_items;
    # Link payments applied to the invoice
    LinkedPayment[] linked_payments;
    json...;
|};

public type BillingAddress record {|
    # First name of the billing address
    string? first_name;
    # Last name of the billing address
    string? last_name?;
    # Company name of the billing address
    string? company?;
    # Line 1 of the billing address
    string? line1?;
    # City of the billing address
    string? city?;
    # satate of the billing address
    string? state?;
    # Country of the billing address
    string? country?;
    # Zip code of the billing address
    string? zip?;
    json...;
|};

public type LineItem record {|
    # Id of the line item
    string id;
    # Date from which the line item is valid
    int date_from;
    # Date to which the line item is valid
    int date_to;
    # Unit amount of the line item
    int unit_amount;
    # Quntity of the line item 
    int quantity;
    # Description of the line item
    string description;
    # Entry type of the line item
    string entity_type;
    # Entry id of the line item
    string entity_id;
    json...;
|};

public type LinkedPayment record {|
    # Transaction id
    string txn_id;
    # Amount applied from the payment to the invoice
    int applied_amount;
    # Applied at timestamp
    int applied_at;
    # Transaction status
    string txn_status;
    # Transaction date
    int txn_date;
    json...;
|};

public type CustomerResponse record {|
    # customer details
    Customer customer;
    json...;
|};

public type Customer record {|
    # Customer id
    string id;
    # Customer first name
    string? first_name;
    # Customer last name
    string? last_name?;
    # Customer company name
    string? company?;
    # Customer email
    string? email;
    # Customer phone number
    string? phone?;
    # Customer created at timestamp
    int? created_at;
    json...;
|};
