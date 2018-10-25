table 50000 "Special Bid"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Vendor No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation  = Vendor."No.";
            
        }
        field(2;"Vendor Bid No."; text [100])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Expiry Date";date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"One Time Bid";boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK;"Vendor No.","Vendor Bid No.")
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