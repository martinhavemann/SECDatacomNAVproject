pageextension 50032 "Inventory Availability" extends "Purchase Line FactBox"
{
    layout
    {
        addafter(Availability)
        {
            field("Curr. Invt";CurrentAvailability)
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    var
        CurrentAvailability : Text;

    trigger OnAfterGetRecord();
    var
        CalcAvailInv : Codeunit "Calculate Available Inventory";
        Item : Record Item;
    begin
        Item.SetRange("No.","No.");
        CalcAvailInv.FindAvailableInventory(Item);
    end;
}