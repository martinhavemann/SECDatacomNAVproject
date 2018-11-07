codeunit 50000 "Advanced Price Management"
{
    EventSubscriberInstance = StaticAutomatic;

    local procedure UpdateSalesLineWithPurchPrice(var SalesLine : Record "Sales Line");
    var
        Item : Record Item;
        PurchPrice : Record "Purchase Price";
    begin
        if SalesLine.Type <> SalesLine.Type::Item then
            Exit;
        if not Item.get(SalesLine."No.") then
            exit;
        PurchPrice.SetRange("Item No.",ITEM."No.");
        PurchPrice.SetRange("Vendor No.",Item."Vendor No.");
        PurchPrice.SetRange("Variant Code",SalesLine."Variant Code");
        PurchPrice.SetFilter("Ending Date",'..%1',WorkDate);
        if PurchPrice.FindLast then
            SalesLine.validate("Unit Purchase Price",PurchPrice."Direct Unit Cost")
        else
            SalesLine.validate("Unit Purchase Price",item."Unit Cost");
            //Need to add currency and UOM and bids...
    end;
    


    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterUpdateAmounts', '', true, true)]
    local procedure SalesLineOnAfterUpdateAmounts(var SalesLine : Record "Sales Line")
    begin
        if SalesLine."Unit Purchase Price" = 0 then
            UpdateSalesLineWithPurchPrice(SalesLine);
        SalesLine.CalcAdvancedPrices;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure SalesHeaderOnBeforeReleaseSalesDoc(var SalesHeader : Record "Sales Header"; PreviewMode : Boolean)
    var 
        SalesLine : Record "Sales Line";   
    begin
        SalesLine.SetRange("Document No.",SalesHeader."No.");
        if SalesLine.FindSet then repeat
            if SalesLine."Bid Unit Sales Price" <> 0 then
                SalesLine.TestField("Bid No.");
            if SalesLine."Bid Unit Purchase Price" <> 0 then
                SalesLine.TestField("Bid No.");
        until SalesLine.Next = 0;
    end;


}