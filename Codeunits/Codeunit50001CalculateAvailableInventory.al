codeunit 50001 "Calculate Available Inventory"
{
    trigger OnRun();
    begin
    end;
    
    procedure FindAvailableInventory(VAR PurchLine: Record "Purchase Line") :Decimal
    Begin
        Location.SetRange("External Location",TRUE);
        if Location.FindSet then repeat
            PurchLine."Location Code" := Location.code;
            AvailableInv := AvailableInv - PurchInfoPaneManage.CalcAvailability(PurchLine);
        until Location.Next = 0;
        exit(AvailableInv);
    End;

    Var
        Location :Record Location;
        AvailableInv : Decimal;
        PurchInfoPaneManage : Codeunit "Purchases Info-Pane Management";

}