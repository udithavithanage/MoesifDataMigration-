type InvoiceList record {|
    Invoice invoice;
|};

type InvoiceResponse record {|
    InvoiceList[] list;
    string? next_offset;
|};

type Invoice record {|
    string id;
    string customer_id;
    string subscription_id;
    string status;
    int date;
    int total;
    int amount_paid;
    int paid_at;
    string currency_code;
    BillingAddress? billing_address;
    LineItem[] line_items;
    LinkedPayment[] linked_payments;
    json...;
|};

type BillingAddress record {|
    string? first_name;
    string? last_name;
    string? company?;
    string? line1;
    string? city;
    string? state;
    string? country;
    string? zip?;
    json...;
|};

type LineItem record {|
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

type LinkedPayment record {|
    string txn_id;
    int applied_amount;
    int applied_at;
    string txn_status;
    int txn_date;
    json...;
|};

type CustomerResponse record {|
    Customer customer;
|};

type Customer record {|
    string id;
    string? first_name;
    string? last_name;
    string? company;
    string? email;
    string? phone;
    int? created_at;
|};
