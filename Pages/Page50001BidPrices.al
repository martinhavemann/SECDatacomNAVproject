page 50001 "Bid Prices"
{
    PageType = List;
    SourceTable = "Bid Prices";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bid Unit Sales Price";"Bid Unit Sales Price")
                {
                    ApplicationArea = all;
                }
                field("Bid Sales Discount";"Bid Sales Discount")
                {
                    ApplicationArea = all;
                }
                field("Bid Unit Purchase Price";"Bid Unit Purchase Price")
                {
                    ApplicationArea = all;
                }
                field("Bid Purchase Discount";"Bid Purchase Discount")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                end;
            }
        }
    }
}