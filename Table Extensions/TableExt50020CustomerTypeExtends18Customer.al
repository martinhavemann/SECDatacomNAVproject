tableextension 50020 CustomerType extends 18
{
    fields
    {
        field(50000;CustomerType;Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "End Customer","Reseller","Manufacturer","Financing Partner";
            InitValue = "Reseller";
        }
        

    }
    
    var
        myInt : Integer;
}