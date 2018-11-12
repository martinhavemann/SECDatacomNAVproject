pageextension 50020 CustomerType extends 21
{
    layout
    {
        addafter("IC Partner Code")
        {        
            field("Customer Type";"Customer Type")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        
    }
    
    var
        myInt : Integer;
}