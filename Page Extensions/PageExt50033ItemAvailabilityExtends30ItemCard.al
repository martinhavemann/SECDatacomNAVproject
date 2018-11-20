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
                Caption = 'Item Availability';
                trigger OnAction();
                var
                AvailableInv : Query "Available Inventory";
                begin
                    AvailableInv.Open;
                    AvailableInv.Read;
                end;
            }
        }
    }
    
    var

}