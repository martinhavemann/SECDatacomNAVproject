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
    
    local procedure FindPriceGroupsFromItem(Item : Record Item; var SalesLineDiscountTemp : Record "Sales Line Discount" temporary ) FoundSome : boolean;
    var
        ItemDiscGroup : Record "Item Discount Group";
        SalesLineDiscount : Record "Sales Line Discount";
    begin
        if not ItemDiscGroup.Get(Item."Item Disc. Group") then
            exit(false);
        SalesLineDiscount.SetRange(Type,SalesLineDiscount.Type::"Item Disc. Group");
        SalesLineDiscount.SetRange(Code,item."Item Disc. Group");
        SalesLineDiscount.SetRange("Sales Type",SalesLineDiscount."Sales Type"::"Customer Disc. Group");
        if SalesLineDiscount.FindSet then begin
            repeat
                SalesLineDiscountTemp := SalesLineDiscount;
                if not SalesLineDiscountTemp.Insert then;
            until SalesLineDiscount.next = 0;
            exit(true)
        end else
            exit(false);
    end;


    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterUpdateAmounts', '', true, true)]
    local procedure SalesLineOnAfterUpdateAmounts(var SalesLine : Record "Sales Line")
    begin
        if SalesLine."Unit Purchase Price" = 0 then
            UpdateSalesLineWithPurchPrice(SalesLine);
        SalesLine.CalcAdvancedPrices;
    end;
    
    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterAssignItemValues', '', true, true)]
    local procedure SalesLineOnAfterAssignItemValues(var SalesLine : Record "Sales Line";Item : Record Item)
    var
        SalesLineDiscountTemp : Record "Sales Line Discount" temporary;
        PriceGroupLink : Record "Price Group Link";
        FoundGroup : Boolean;
    begin
        if FindPriceGroupsFromItem(Item,SalesLineDiscountTemp) then begin
            PriceGroupLink.SetRange("Customer No.",SalesLine."Sell-to Customer No.");
            if PriceGroupLink.FindSet then repeat
                SalesLineDiscountTemp.SetRange("Sales Code",PriceGroupLink."Customer Discount Group Code");
                if SalesLineDiscountTemp.FindFirst then begin
                    SalesLine."Customer Disc. Group" := SalesLineDiscountTemp."Sales Code";
                    SalesLine."Customer Price Group" := SalesLine."Customer Disc. Group";
                    FoundGroup := true;
                end;
            until  (PriceGroupLink.Next = 0) or (FoundGroup);
        end;
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