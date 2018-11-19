tableextension 50026 "Credit Limit" extends 23
{
    fields
    {
        field(50000;"Credit Limit Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Credit Limit Currency";Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
            trigger Onlookup();
            var
                Currency : Record Currency;
            begin
                Currency.SetRange(Currency.Code,"Credit Limit Currency");
                IF page.RunModal(page::"Currencies",Currency) = Action::LookupOK then
                    Validate("Credit Limit Currency",Currency.Code);
            end;
        }
    }
    
    var
        myInt : Integer;
}