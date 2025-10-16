public type InvoiceRecord record {|
    Invoice invoice;
|};

public type InvoiceResponse record {|
    InvoiceRecord[] list;
    string? next_offset;
|};

public type Invoice record {|
    string id;
    string customer_id;
    string subscription_id?;
    string status;
    int date;
    int total;
    int amount_paid;
    int paid_at?;
    string currency_code;
    BillingAddress? billing_address;
    LineItem[] line_items;
    LinkedPayment[] linked_payments;
    json...;
|};

public type BillingAddress record {|
    string? first_name;
    string? last_name?;
    string? company?;
    string? line1?;
    string? city?;
    string? state?;
    string? country?;
    string? zip?;
    json...;
|};

public type LineItem record {|
    string id;
    int date_from;
    int date_to;
    int unit_amount;
    int quantity;
    string description;
    string entity_type;
    string entity_id;
    json...;
|};

public type LinkedPayment record {|
    string txn_id;
    int applied_amount;
    int applied_at;
    string txn_status;
    int txn_date;
    json...;
|};

public type CustomerResponse record {|
    Customer customer;
    json...;
|};

public type Customer record {|
    string id;
    string? first_name;
    string? last_name?;
    string? company?;
    string? email;
    string? phone?;
    int? created_at;
    json...;
|};
