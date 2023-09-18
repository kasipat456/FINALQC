pageextension 50101 "Pex_reelease" extends "Released Production Order"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("References Document No"; Rec."References Document No")
            {
                Caption = 'References Document No';
                ApplicationArea = All;
            }
            field("References Line No"; Rec."References Line No")
            {
                Caption = 'References Line No';
                ApplicationArea = All;
            }
            field("Defact Daecription"; Rec."Defact Daecription")
            {
                Caption = 'Defact Daecription';
                ApplicationArea = All;
            }
        }

    }

}