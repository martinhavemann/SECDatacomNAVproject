report 50000 "Update Purc. Disc. Item Group"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Counter; Integer)
        {
           MaxIteration = 1; 
           trigger OnAfterGetRecord();
           var
               AdvPriceMgt : Codeunit "Advanced Price Management";
           begin
               //AdvPriceMgt.;
           end;

           trigger OnPostDataItem();
           begin
               Message('something happened');
           end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    field("item Disc. Group";ItemDiscGroup.Code)
                    {
                        trigger OnLookup(Text : Text) : Boolean;
                        var
                            myInt : Integer;
                        begin
                            if Page.RunModal(page::"Item Disc. Groups",ItemDiscGroup) <> "Action"::LookupOK then
                                Clear(ItemDiscGroup);
                        end;
                    }
                    field("New Disc Percentage";NewDiscpercentage)
                    {

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
                }
            }
        }
    }
    
    var
        ItemDiscGroup : Record "Item Discount Group";
        NewDiscpercentage : Decimal;
}