tableextension 50000 "Sales Line Bid" extends "Sales Line"
{
    fields
    {
        field(50000;"Bid No.";code [20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Bid."Bid No.";

            trigger OnLookUp();
            var
                Item : Record Item;
                Bid : Record Bid;
            begin
                if item.Get("No.") then begin
                    Bid.SetRange("Vendor No.",item."Vendor No."); // here we need to look at the price lists as well not just the item
                    Page.RunModal(50000,Bid);
                end    
            end;
        }
        field(50001;"Bid Sales Price";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002;"Bid Sales Discount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Purchase Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011;"Bid Purchase Price";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                if "Bid Purchase Price" <> xRec."Bid Purchase Price" then 
                    CalcAdvancedPrices;    
            end;
        }
        field(50012;"Bid Purchase Discount";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                if "Bid Purchase Discount" <> xRec."Bid Purchase Discount" then 
                    CalcAdvancedPrices;    
            end;

        }
        field(50013;"Transfer Price Markup";Decimal)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(50014;"KickBack Percentage";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50015;"Kickback Amount";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020;"Calculated Purchase Price";Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger Onvalidate();
            var
                myInt : Integer;
            begin
                //the price calculation goes here? or perhaps in a function that updates this field?
            end;
        }
        field(50021;"Claimable";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022;"Claim Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(500023;"Profit Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50024;"Profit Margin";decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50025;"Purchase Price on Purchase Order";Decimal)
        {
            DataClassification = ToBeClassified;
        }

    }
    
    var
        myInt : Integer;
        
    local procedure CalcAdvancedPrices();
    var
        TransferPriceAmount : Decimal;
    begin
        if ("Bid Purchase Price" = 0) and ("Transfer Price Markup" = 0) and ("Kickback Amount" = 0) then begin 
            "Calculated Purchase Price" := "Purchase Price";
            exit;
        end;

        if "KickBack Percentage" <> 0 then
            If "Bid Purchase Price" <> 0 then
                "Kickback Amount" := "Bid Purchase Price" * (1+("KickBack Percentage"/100))
            else
                "Kickback Amount" := "Purchase Price" * (1+("kickback percentage"/100));
             
        if "Transfer Price Markup" <> 0  then
            If "Bid Purchase Price" <> 0 then
                TransferPriceAmount := "Bid Purchase Price" * (1+("Transfer Price Markup"/100))
            else
                TransferPriceAmount := "Purchase Price" * (1+("Transfer Price Markup"/100));
        
           
            
    end;
}