table 50101 Prices
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;Customer;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Price;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK;Customer)
        {
            Clustered = true;
        }
    }
    
    var
        myInt : Integer;

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}