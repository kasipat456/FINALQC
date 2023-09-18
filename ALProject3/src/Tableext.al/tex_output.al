tableextension 90003 "tex_output" extends "Item Journal Line"
{
    fields
    {
        // modify("Order No.")
        // {
        //     trigger OnAfterValidate()
        //     var

        //     begin
        //         rec."Document No." := '232322332';
        //         rec.Description := 'tedt';
        //     end;
        // }
        field(50200; "References Document No"; Code[20])
        {
            Caption = 'References Document No';
            DataClassification = ToBeClassified;
        }
        field(50300; "References Line No"; Integer)
        {
            Caption = 'References Line No';
            DataClassification = ToBeClassified;
        }

    }
}