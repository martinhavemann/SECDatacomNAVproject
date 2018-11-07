table 50001 "Bid Prices"
{
    DataClassification = ToBeClassified;
    // The fields with 50000's numbers have those because then we can use transferfields to get them on the Sales Line
    fields
    {
        field(1;"Bid No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bid."Bid No.";
            NotBlank = true;
        }
        field(2;"item No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No.";
            NotBlank = true;
        }
        field(3;"Customer No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
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
        key(PK;"Bid No.","item No.","Customer No.")
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