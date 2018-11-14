pageextension 50005 "Price Wrksh. Adv. Pricing" extends "Sales Price Worksheet"
{
    actions
    {
        addafter("I&mplement Price Change")
        {
            action("Update prices from Discounts")
            {
                Image = ItemGroup;
                trigger OnAction();
                begin
                    Codeunit.Run(Codeunit::"Advanced Price Management");
                end;
            }
        }    
    }
    
}