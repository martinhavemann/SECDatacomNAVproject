codeunit 50000 "Advanced Price Management"
{
    EventSubscriberInstance = StaticAutomatic;

    trigger OnRun();
    begin

    end;
    


    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterUpdateAmounts', '', true, true)]
    local procedure SalesLineOnAfterUpdateAmounts(var SalesLine : Record "Sales Line")
    begin
        SalesLine.CalcAdvancedPrices;
    end;
}