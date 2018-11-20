pageextension 50032 "Available Inventory" extends 9100
{
    layout
    {
        addafter(Availability)
        {
            field("Availability IC";STRSUBSTNO('%1',AvailableInventory.Inventory))
            {

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    var
        AvailableInventory : Query 50000;
}