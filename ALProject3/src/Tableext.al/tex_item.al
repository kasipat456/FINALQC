tableextension 90000 "tex_item" extends "Inventory Setup"
{
    fields
    {
        field(50200; "Document No"; Code[20])
        {
            Caption = '"Document No';
            TableRelation = "No. Series";
        }
        field(50300; "Journal Template Name"; Code[10])
        {
            Caption = 'Jornal Template Name';
            TableRelation = "Item Journal Template";
        }
        field(50400; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(50500; "Default Location Code"; Code[10])
        {
            Caption = 'Default Location Code';
            TableRelation = Location;
        }

    }
}
