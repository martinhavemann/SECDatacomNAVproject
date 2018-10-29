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
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt : Integer;
}