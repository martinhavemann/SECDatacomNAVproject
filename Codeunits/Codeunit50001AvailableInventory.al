codeunit 50001 "Calculate Available Inventory"
{
    trigger OnRun();
    begin
    end;
    
    procedure FindAvailableInventory(Item: Record Item) :Decimal
    Begin
        exit(123)
    End;

    var
        
        
}