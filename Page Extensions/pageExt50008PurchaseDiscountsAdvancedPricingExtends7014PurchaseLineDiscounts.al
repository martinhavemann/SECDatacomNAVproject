pageextension 50008 "Purchase Disc. Adv. Pricing" extends "Purchase Line Discounts"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        
        addlast(Sections)
        {
            group("Process")
            {
                action(UpdateDiscunts)
                {
                Caption = 'Update Discounts';
                Image = UpdateUnitCost;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Message('Under Construction')
                end;
                }
                 
            }
        }
    }
}