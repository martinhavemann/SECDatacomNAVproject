table 50001 "Bid Prices"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Bid No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bid."Bid No.";
        }
        field(2;"Bid Line No.";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001;"Bid Unit Sales Price";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Bid Sales Discount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"Bid Unit Purchase Price";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50012;"Bid Purchase Discount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK;"Bid No.","Bid Line No.")
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