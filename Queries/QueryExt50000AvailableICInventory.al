query 50000
{
    
    elements
    {
        dataitem(DataItemName; Item)
        {
            column(Inventory; Inventory)
            {
            }

        }
    }
    
    var
        myInt : Integer;

    trigger OnBeforeOpen();
    begin
    end;
}