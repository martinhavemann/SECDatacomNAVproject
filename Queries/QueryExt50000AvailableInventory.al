query 50000 "Available Inventory"
{
    QueryType = API;
    elements
    {
        dataitem(DataItemName; Item)
        {
            column(Inventory; Inventory)
            {
                Method = Sum;
            }

        }
    }
    
    var
        myInt : Integer;

    trigger OnBeforeOpen();
    begin
        
    end;
}