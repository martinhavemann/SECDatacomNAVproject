pageextension 50006 "Currencies Adv. Pricing" extends currencies
{
    layout
    {
        addafter(ExchangeRateAmt)
        {
            field("Make Prices";"Make Prices")
            {
                ApplicationArea = ll;
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