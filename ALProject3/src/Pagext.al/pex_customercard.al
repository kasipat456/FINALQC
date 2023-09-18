pageextension 90002 Item_card extends "Customer Card"
{
    trigger OnOpenPage();
    begin
        CurrPage.Editable(false);
    end;
}