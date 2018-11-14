codeunit 50000 "Advanced Price Management"
{
    EventSubscriberInstance = StaticAutomatic;

    trigger OnRun();
    var
        DiscontGroupFilters : Record "Sales Line Discount";
    begin
        DiscontGroupFilters.SetRange(Type,DiscontGroupFilters.type::"Item Disc. Group");
        DiscontGroupFilters.SetRange(Code,'TESTVARER');
        CalcGroupPricesFromGroupDiscounts(DiscontGroupFilters);
    end;

    procedure CalcGroupPricesFromGroupDiscounts(var DiscontGroupFilters : Record "Sales Line Discount");
    var
        SalesDiscountGroup : Record "Sales Line Discount";
        SalesPriceWorksheet : Record "Sales Price Worksheet";
        ItemListPrice : Record "Sales Price";
        ItemsExistInGroup : Boolean;
        ItemTemp : Record Item temporary;
    begin
        SalesDiscountGroup.CopyFilters(DiscontGroupFilters);
        if SalesDiscountGroup.FindSet then repeat
            ItemsExistInGroup := FindItemsInItemDiscGroup(ItemTemp,SalesDiscountGroup);
            if ItemsExistInGroup then begin
                ItemTemp.FindFirst;
                repeat
                    if FindListPriceForitem(ItemTemp."No.",ItemListPrice) then begin
                        SalesPriceWorksheet.validate("Item No.",ItemTemp."No.");
                        SalesPriceWorksheet.Validate("Currency Code",ItemListPrice."Currency Code");
                        CreateWorksheetLineFromDiscountGroup(SalesDiscountGroup,SalesPriceWorksheet);
                        if SalesPriceWorksheet."Unit of Measure Code" = '' then
                            SalesPriceWorksheet."Unit of Measure Code" := ItemTemp."Sales Unit of Measure";
                        SalesPriceWorksheet."New Unit Price" := ItemListPrice."Unit Price" *((100-SalesDiscountGroup."Line Discount %")/100);
                        SalesPriceWorksheet.Insert(true);
                    end;
                until ItemTemp.next = 0;
            end;
        until SalesDiscountGroup.next = 0;
    end;

    local procedure FindListPriceForitem(ItemNo : code[20]; var ListPrice : record "sales price") : Boolean;
    var
        Test : Integer;
    begin
        ListPrice.SetRange("Item No.",ItemNo);
        ListPrice.SetRange("Sales Type",ListPrice."Sales Type"::"All Customers");
        exit(listprice.FindLast);
    end;

    local procedure FindItemsInItemDiscGroup(var ItemTemp : Record Item temporary; SalesDiscGroup : Record "Sales Line Discount") : Boolean;
    var
        Item : Record Item;
    begin
        Item.SetRange("Item Disc. Group",SalesDiscGroup.Code);
        if Item.FindSet then begin
            repeat
                ItemTemp := Item;
                if not ItemTemp.Insert then;                
            until Item.next = 0;
            exit(true);
        end else begin
            clear(ItemTemp);
            exit(false);
        end;

    end;

    local procedure CreateWorksheetLineFromDiscountGroup(DiscountGroup : Record "Sales Line Discount"; var WorkSheet : Record "Sales Price Worksheet");
    begin
        WorkSheet.Validate("Sales Type",DiscountGroup."Sales Type");
        WorkSheet.Validate("Sales Code",DiscountGroup."Sales Code");
        WorkSheet.Validate("Starting Date",DiscountGroup."Starting Date");
        WorkSheet.Validate("Minimum Quantity",DiscountGroup."Minimum Quantity");
        if DiscountGroup."Ending Date" <> 0D then
            WorkSheet.Validate("Ending Date",DiscountGroup."Ending Date");
        WorkSheet.Validate("Unit of Measure Code",DiscountGroup."Unit of Measure Code");
        WorkSheet.Validate("Variant Code",DiscountGroup."Variant Code");
    end;
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