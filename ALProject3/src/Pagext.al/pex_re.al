pageextension 90003 pex_re extends "Released Production Orders"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("References Document No"; Rec."References Document No")
            {
                ApplicationArea = All;
                Caption = 'References Document No';
            }
        }
        addbefore(Quantity)
        {
            field("Defact Daecription"; Rec."Defact Daecription")
            {
                ApplicationArea = All;
                Caption = 'Defact Daecription';
            }
        }
    }



}