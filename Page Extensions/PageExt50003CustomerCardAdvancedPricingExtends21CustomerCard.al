pageextension 50003 "Customer Card Advacned Pricing" extends "Customer Card"
{
   
    actions
    {
        
        addafter("Line Discounts")
        {
            action("Customer Price Groups")
            {
                Image = CustomerGroup;
                trigger OnAction();
                var 
                    PriceGroupLink : Record "Price Group Link";
                begin
                    PriceGroupLink.SetRange("Customer No.","No.");
                    Page.RunModal(50002,PriceGroupLink);
                end;
            }
        }
    }
    
    
}