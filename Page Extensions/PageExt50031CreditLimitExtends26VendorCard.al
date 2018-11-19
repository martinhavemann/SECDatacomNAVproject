pageextension 50031 "Credit Limit" extends 26
{
    layout
    {
        addafter("Prices Including VAT")
        {
            field("Credit Limit Amount";"Credit Limit Amount")
            {
                ApplicationArea = all;
            }
            field("Credit Limit Currency";"Credit Limit Currency")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt : Integer;
}