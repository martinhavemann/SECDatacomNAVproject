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
               myInt : Integer;
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