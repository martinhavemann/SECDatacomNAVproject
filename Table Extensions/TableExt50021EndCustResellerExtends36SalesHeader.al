tableextension 50021 "End Customer and Reseller" extends 36
{
    fields
    {
        field(50000;"End Customer";Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
        }
    }
    
    var
        myInt : Integer;
}