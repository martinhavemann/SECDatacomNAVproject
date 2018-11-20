pageextension 50033 "Item Availability" extends 30
{
    layout
    {
        
    }

    actions
    {
        addafter("F&unctions")
        {
            action("Item Availability")
            {
                Image = Start;
                Promoted = true;
                RunObject = report 50000;
            }
        }
    }
    
    var

}