tableextension 50021 "End Customer and Reseller" extends 36
{
    fields
    {
        field(50000;"End Customer";Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            trigger Onlookup();
            var
                Customer : Record Customer;
            begin
                Customer.SetRange("Customer Type",customer."Customer Type"::"End Customer");
                IF page.RunModal(page::"Customer List",Customer) = Action::LookupOK then
                    Validate("End Customer",customer."No.");
            end;
        }
    }
    
    var
        myInt : Integer;
}