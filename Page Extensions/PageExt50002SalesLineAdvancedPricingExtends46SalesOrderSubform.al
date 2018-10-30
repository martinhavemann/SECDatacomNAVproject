pageextension 50002 "Sales Line Bid" extends "Sales Order Subform"
{
    layout
    {
        addafter("Line Discount %")
        {
            field("Bid No.";"Bid No.")
            {
                ApplicationArea = All;
            }
            field("Bid Sales Price";"Bid Sales Price")
            {
                ApplicationArea = All;
            }
            field("Bid Sales Discount";"Bid Sales Discount")
            {
                ApplicationArea = All;
            }
            field("Purchase Price";"Purchase Price")
            {
                ApplicationArea = All;
            }
            field("Bid Purchase Price";"Bid Purchase Price")
            {
                ApplicationArea = All;
            }
            field("Bid Purchase Discount";"Bid Purchase Discount")
            {
                ApplicationArea = All;
            }
            field("Transfer Price Markup";"Transfer Price Markup")
            {
                ApplicationArea = All;
            }
            field("KickBack Percentage";"KickBack Percentage")
            {
                ApplicationArea = All;
            }
            field("Kickback Amount";"Kickback Amount")
            {
                ApplicationArea = All;
            }
            field("Calculated Purchase Price";"Calculated Purchase Price")
            {
                ApplicationArea = All;
            }
            field(Claimable;Claimable)
            {
                ApplicationArea = All;
            }
            field("Claim Amount";"Claim Amount")
            {
                ApplicationArea = All;
            }
            field("Profit Amount";"Profit Amount")
            {
                ApplicationArea = All;
            }
            field("Profit Margin";"Profit Margin")
            {
                ApplicationArea = All;
            }
            field("Purchase Price on Purchase Order";"Purchase Price on Purchase Order")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt : Integer;
}