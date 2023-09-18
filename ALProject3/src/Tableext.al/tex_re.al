tableextension 90002 Tex_re extends "Production Order"
{

    fields
    {

        field(50200; "References Document No"; Code[20])
        {
            Caption = 'Refernces Document No';
            DataClassification = ToBeClassified;
        }

        field(50300; "References Line No"; Integer)
        {
            Caption = 'References Line No';
            DataClassification = ToBeClassified;
        }
        field(50400; "Defact Daecription"; Text[100])
        {
            Caption = 'References Line No';
            DataClassification = ToBeClassified;
        }



    }

    var
        myInt: Integer;
}