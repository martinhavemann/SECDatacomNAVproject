table 50000 "Bid"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Bid No.";Code [20])
        {
            DataClassification = ToBeClassified;
        }
        
        field(2;"Vendor No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation  = Vendor."No.";
            
        }
        field(3;"Vendor Bid No."; text [100])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Expiry Date";date)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"One Time Bid";boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK;"Bid No.")
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