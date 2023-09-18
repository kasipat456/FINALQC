tableextension 90004 Pro extends "Prod. Order Line"
{

    fields
    {

        field(50200; "Next Operation No."; Code[20])
        {
            Caption = 'Next Operation No.';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}