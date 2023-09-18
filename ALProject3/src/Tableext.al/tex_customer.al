tableextension 90001 Tableext extends Customer
{
    fields
    {
        field(50300; "Kasipat Jansoon"; Text[120])
        {
            Caption = 'Kasipat Jansoon';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}