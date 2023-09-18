report 90000 Report_one
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/report_gradelist.rdl';


    dataset
    {
        dataitem("product grade sorting header"; "product grade sorting header")//level 1
        {
            column(Document_No; "Document No") { }
            column(Document_Date; "Document Date") { }
            column(Employee_name; "Employee name") { }
            column(Employee_No; "Employee No") { }
            column(Department_Code; "Department Code") { }
            column(Item_A; "Item A") { }
            column(Item_C; "Item C") { }
            column(Item_Scap; "Item Scap") { }
            column(Grade_A; "Grade A") { }
            column(Grade_C; "Grade C") { }
            column(Grade_Scap; "Grade Scap") { }
            column(Grade_A_number; "Grade A number") { }
            column(Grade_C_number; "Grade C number") { }
            column(Grade_Scap_number; "Grade Scap number") { }
            column(C_Var__; "C Var.%") { }
            column(A__Var__; "A. Var.%") { }
            column(Scap_Var__; "Scap Var.%") { }
            column(Total; Total) { }
            column(CompanyPic; CompanyInformation.Picture) { }
            column(Address; CompanyInformation.Address) { }
            column(Address2; CompanyInformation."Address 2") { }
            column(City; CompanyInformation.City) { }
            column("Post_code"; CompanyInformation."Post Code") { }
            column("Phone_no"; CompanyInformation."Phone No.") { }
            // column("Phone_no"; CompanyInformation."Company Name In Thai") { }








            //----------------------------------------------------------------------
            dataitem("product grade sorting line"; "product grade sorting line")
            {
                DataItemLink = "Document No" = field("Document No");
                column(Defact_item_No_; "Defact item No.") { }

                column(Description; Description) { }
                column(Defact_Reason_Code; "Defact Reason Code") { }
                column(Defact_Daecription; "Defact Daecription") { }
                column(Location_Code; "Location Code") { }
                column(Defact_Qty; "Defact Qty") { }
                column(References_Production_order; "References Production order") { }
                column(Number; Num) { }

                trigger OnAfterGetRecord() // ดำเนินการหลังจากดึง
                begin
                    Num := Num + 1;
                end;
            }
            dataitem(emptyline; Integer)
            {
                column(dataline; Number) { }
                trigger OnPreDataItem()
                var
                    dataline1: Integer;
                    endline: Integer;

                begin
                    Tempproductgradesortingline.Reset();
                    if Tempproductgradesortingline.FindSet() then begin
                        dataline1 := Tempproductgradesortingline.Count;
                    end;
                    endline := 19;
                    repeat
                        if endline < dataline1 then begin
                            endline += 19;
                        end;
                    until endline > dataline1;
                    SetRange(Number, dataline1, endline - 1);
                end;
            }

        }
    }




    trigger OnInitReport()
    begin

    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);
    end;

    var

        CompanyInformation: Record "Company Information";

        Tempproductgradesortingline: Record "product grade sorting line" temporary;
        Num: Integer;
}