tableextension 50000 "Sales Line Bid" extends "Sales Line"
{
    fields
    {
        field(50000;"Bid No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bid."Bid No.";
        }
        field(50001;"Bid Sales Price";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Bid Sales Discount";Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }
    
    var
        myInt : Integer;
}