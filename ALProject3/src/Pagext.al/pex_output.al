pageextension 90000 "pex_output" extends "Inventory Setup"
{
    layout
    {
        addafter("Item Nos.")
        {
            field("Document No"; Rec."Document No")
            {
                Caption = 'Document No';
                ApplicationArea = All;
            }
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                Caption = 'Jornal Template Name';
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                Caption = 'Jornal Batch Name';
                ApplicationArea = All;
            }
            field("Default Location Code"; Rec."Default Location Code")
            {
                Caption = 'Default Location Code';
                ApplicationArea = All;
            }

        }
    }
}