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
                    if Page.RunModal(50000,Bid) = "Action"::LookupOK then 
                        validate("Bid No.",Bid."Bid No.");
                end    
            end;

            trigger Onvalidate();
            var
                Bid : Record Bid;
            begin
                if Bid.Get("Bid No.") then;
                 //Insert some fancy code here that updates the bid price ann cost fields
            end;
        }
        field(50001;"Bid Sales Price";Decimal)
        {
            DataClassification = ToBeClassified;
            
            trigger onvalidate();

            begin
                if "Bid Sales Price" <> 0 then
                    validate("Unit Price","Bid Sales Price")
                else
                    Validate(Quantity); //code here that finds the original sales price without bid
            end;
        }
        field(50002;"Bid Sales Discount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010;"Purchase Price"; Decimal)
        {
            DataClassification = ToBeClassified;
                        trigger Onvalidate()
            begin
                if "Purchase Price" <> xRec."Purchase Price" then 
                    CalcAdvancedPrices;    
            end;
        }
        field(50011;"Bid Purchase Price";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                if "Bid Purchase Price" <> xRec."Bid Purchase Price" then 
                    CalcAdvancedPrices;
                if "Bid Purchase Price" <> 0 then 
                    Claimable := true;
            end;
        }
        field(50012;"Bid Purchase Discount";Decimal)
        {
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            begin
                if "Bid Purchase Discount" <> xRec."Bid Purchase Discount" then 
                    CalcAdvancedPrices;    
                if "Bid Purchase Discount" <> 0 then 
                    Claimable := true;                    
            end;

        }
        field(50013;"Transfer Price Markup";Decimal)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            trigger Onvalidate()
            begin
                if "Transfer Price Markup" <> xRec."Transfer Price Markup" then 
                    CalcAdvancedPrices;    
            end;
        }
        field(50014;"KickBack Percentage";Decimal)
        {
            DataClassification = ToBeClassified;
            //Editable = false;
            trigger Onvalidate()
            begin
                If "KickBack Percentage" = 0 then
                    "Kickback Amount" := 0;
                if "KickBack Percentage" <> xRec."KickBack Percentage" then 
                    CalcAdvancedPrices;    
            end;
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
            "Profit Amount" := "Unit Price" - "Calculated Purchase Price";
            "Profit Margin" := ("Profit Amount" / "Unit Price") * 100;
            "Purchase Price on Purchase Order" := "Purchase Price";
            exit;
        end;

        if "KickBack Percentage" <> 0 then
            If "Bid Purchase Price" <> 0 then
                "Kickback Amount" := "Bid Purchase Price" * ("KickBack Percentage"/100)
            else
                "Kickback Amount" := "Purchase Price" * ("kickback percentage"/100);
             
        if "Transfer Price Markup" <> 0  then
            If "Bid Purchase Price" <> 0 then
                TransferPriceAmount := "Bid Purchase Price" * ("Transfer Price Markup"/100)
            else
                TransferPriceAmount := "Purchase Price" * ("Transfer Price Markup"/100);

        If "Bid Purchase Price" <> 0 then begin
            "Calculated Purchase Price" := "Bid Purchase Price" + TransferPriceAmount;
            "Purchase Price on Purchase Order" := "Bid Purchase Price";
        end else begin 
            "Calculated Purchase Price" := "Purchase Price" + TransferPriceAmount;
            "Purchase Price on Purchase Order" := "Purchase Price";
        end;    

        "Profit Amount" := "Unit Price" - "Calculated Purchase Price" - "Kickback Amount";
        "Profit Margin" := ("Profit Amount" / "Unit Price") * 100;
        "Claim Amount" := "Purchase Price" - "Bid Purchase Price";

           
            
    end;
}