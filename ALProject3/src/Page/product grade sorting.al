page 90024 "product grade sorting"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "product grade sorting header";
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            group(Information)
            {
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    Lookup = false;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then //  OnAssistEdit Trigger เพื่อเปลี่ยนพฤติกรรมการช่วยแก้ไขเริ่มต้น 
                                                     //xRecแสดงถึงเรคคอร์ดก่อนที่จะถูกแก้ไข
                                                     //Recถึงข้อมูลเรคคอร์ดปัจจุบันที่อยู่ระหว่างดำเนินการ

                            CurrPage.Update(); // CurrPage = หน้านี้  Update = อัพเดช  รวมคือเมื่อมีการทำอะไรกับ Field นี้จะมีการอัพเดช
                    end;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee name"; Rec."Employee name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                grid(MyGrid)
                {
                    Caption = 'เกรด A';
                    group("เกรด A")
                    {
                        field("Item A"; Rec."Item A")
                        {
                            ApplicationArea = All;
                        }
                    }
                    grid("จำนวน A")
                    {
                        field("Grade A"; Rec."Grade A")
                        {
                            ApplicationArea = all;
                        }
                    }
                }

            }
            //---------------------------------------------------------------------------------------------------------------
            group(คัดแยกเกรด)
            {

                grid(MyGrid2)
                {
                    group("เกรด C")
                    {
                        Caption = 'เกรด C';
                        field("Item C"; Rec."Item C")
                        {
                            ApplicationArea = All;
                        }
                    }

                    grid("จำนวน C")
                    {
                        field("Grade C"; Rec."Grade C")
                        {
                            ApplicationArea = all;
                            trigger OnValidate()
                            begin
                                //Message('%1 %2', Rec."Grade C", xRec."Grade C");
                                if test(Rec."Grade C", Rec) then begin
                                    Error('จำนวนไอเทมเกรด C ไม่สามารถเกินจำนวนไอเทมของเกรด A ได้');
                                end;

                            end;
                        }
                    }
                }
                grid(MyGrid3)
                {
                    group("เกรด Scap")
                    {
                        Caption = 'เกรด Scap';
                        field("Item Scap"; Rec."Item Scap")
                        {
                            ApplicationArea = All;
                        }
                    }
                    grid("จำนวน Scap")
                    {
                        field("Grade Scap"; Rec."Grade Scap")
                        {
                            ApplicationArea = all;
                            trigger OnValidate()
                            begin
                                //Message('%1 %2', Rec."Grade C", xRec."Grade C");
                                if test1(Rec."Grade Scap", Rec) then begin // ส่งค่า field Grade Scap / Rec = Header
                                    Error('จำนวนไอเทมเกรด Scap ไม่สามารถเกินจำนวนไอเทมของเกรด A ได้');
                                end;
                            end;
                        }
                    }
                }

            }
            //---------------------------------------------------------------------------------------------
            group(Variance)
            {
                grid(MyGrid4)
                {
                    group(เกรดA)
                    {
                        field("Grade A number"; Rec."Grade A number")
                        {
                            ApplicationArea = All;
                            Style = Favorable;
                        }
                    }
                    grid(Grid5)
                    {
                        field("A. Var.%"; Rec."A. Var.%")
                        {
                            ApplicationArea = All;
                            Style = Favorable;
                        }
                    }
                }
                grid(Grid)
                {
                    group(เกรดC)
                    {
                        field("Grade C number"; Rec."Grade C number")
                        {
                            ApplicationArea = All;
                            Style = Strong;
                        }
                    }
                    grid(Grid6)
                    {
                        field("C Var.%"; Rec."C Var.%")
                        {
                            ApplicationArea = All;
                            Style = Strong;
                        }
                    }
                }
                grid(Grid7)
                {
                    group(เกรดScap)
                    {
                        field("Grade Scap number"; Rec."Grade Scap number")
                        {
                            ApplicationArea = All;
                            Style = Unfavorable; // สีเขียว 
                        }
                    }
                    grid(Grid8)
                    {
                        field("Scap Var.%"; Rec."Scap Var.%")
                        {
                            ApplicationArea = All;
                            Style = Unfavorable; // สีเขียว 
                        }
                    }
                }
                grid(Grid9)
                {
                    group(รวมจำนวนที่Scap)
                    {
                        field(Total; Rec.Total)
                        {
                            Caption = 'จำนวน';
                            ApplicationArea = All;
                            Style = Strong; // ใส่สีดำตัวหนา

                        }
                    }
                }
            }
            part("product grade sorting line"; Lines)
            {
                ApplicationArea = All;
                SubPageLink = "Document No" = FIELD("Document No");
                UpdatePropagation = Both;
            }

        }

    }

    actions
    {
        area(Processing)
        {
            action("Cal Variance")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Quatity();
                end;
            }
            action("Create Released Production Order")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    Mycode: Codeunit "My Codeunit";
                    Mycode1: Codeunit "production sorting";
                    ProdgradesortingLn: Record "product grade sorting line";
                    ProdgradesortingHdr: Record "product grade sorting header";
                    Report_one: Report Report_one;
                begin
                    checkc(Rec."Grade C number", Rec."Item C");
                    checkscap(Rec."Grade Scap number", Rec."Item Scap");
                    Mycode.CreateProdOrder(Rec."Document No");
                    Mycode1.CreateOutPut1(Rec."Document No");
                    // Commit();
                    // report1(Rec."Document No")
                end;

            }
            action("Production Grade Sorting")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    ProdgradesortingHdr: Record "product grade sorting header";
                    Report_one: Report MyReport;
                begin
                    ProdgradesortingHdr.Reset();
                    ProdgradesortingHdr.SetRange("Document No", Rec."Document No");
                    if ProdgradesortingHdr.FindSet() then begin
                        Report.RunModal(Report::Report_one, true, true, ProdgradesortingHdr);
                    end;
                end;
            }
        }

    }
    procedure Quatity()
    var
        Header: Record "product grade sorting header";
        QuarityA: Decimal;  // ประกาศตัวแปร เพื่อมาเก็บค่าของตัวแปร
        SumQuatity: Decimal;
    begin
        Clear(QuarityA); // ลบค่าของ Quality A ออกให้หมดก่อน 
        Header.Reset();
        Header.SetRange("Document No", Rec."Document No"); // setrange หาตัวที่เหมือนกัน
        if Header.findset() then begin // เลือกข้อมูลทั้งหมดที่อยู่ใน Header

            QuarityA := Header."Grade A" - Header."Grade C" - Header."Grade Scap";

            Header."grade C number" := Header."Grade C";
            Header."C Var.%" := (Header."Grade C" / Header."Grade A") * 100;

            Header."Grade Scap number" := Header."Grade Scap";
            Header."Scap Var.%" := (Header."Grade Scap" / Header."Grade A") * 100;

            Header."Grade A number" := QuarityA;
            Header."A. Var.%" := (QuarityA / Header."Grade A") * 100;

            SumQuatity := Header."Grade Scap number" + Header."Grade C number";
            Header.Total := SumQuatity;

            Header.Modify();
        end;
    end;

    var
        ProductionOrder: Record "Production Order";


    // ค่าในช่องเกรด C
    procedure test(GradeC: Decimal; Rec: Record "product grade sorting header"): Boolean
    var
        hd: Record "product grade sorting header";
        TotalGrade: Decimal; // ประกาศตัวแปร 
    begin
        Clear(TotalGrade); // ลบค่าทั้งหมด TotalGrade ทั้งหมด เพื่อไม่ให้ไปคิดค่าเดิม
        TotalGrade := Rec."Grade Scap" + GradeC;
        // Message('%1 %2', Rec."Grade Scap", GradeC);
        if TotalGrade > rec."Grade A" then begin // ถ้า TotalGrade มากกว่า A 
            exit(true);
        end;
    end;

    // ค่าในช่องเกรด Scap
    procedure test1(Gradescap: Decimal; Rec: Record "product grade sorting header"): Boolean
    var
        productgradesortingheader: Record "product grade sorting header";
        Total: Decimal;
    begin
        Clear(Total);
        Total := rec."Grade C" + Gradescap;
        if Total > rec."Grade A" then begin
            // Message('%1 %2', b, rec."Grade A");
            exit(true)
        end;
    end;



    procedure checkscap("Grade Scap number": Decimal; "item scap": code[20])
    var
        scap: Decimal;

        productgradesortingline: Record "product grade sorting line";
    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", Rec."Document No");
        productgradesortingline.SetRange("Defact item No.", "item scap");
        if productgradesortingline.FindSet() then begin
            repeat
                scap += productgradesortingline."Defact Qty";
            until productgradesortingline.Next() = 0;
            if scap <> Rec."Grade Scap" then
                Error('Please enter the complete Scap Grade amount before posting.');
        end;
    end;


    procedure checkc("Grade C number": Decimal; "item C": Code[20])
    var
        c: Decimal;
        productgradesortingline: Record "product grade sorting line";
    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", Rec."Document No");
        productgradesortingline.SetRange("Defact item No.", "item C");
        if productgradesortingline.FindSet() then begin
            repeat
                c += productgradesortingline."Defact Qty"
            until productgradesortingline.Next() = 0;
            if c <> Rec."Grade C" then
                Error('Please enter the complete C Grade amount before posting.');
        end;
    end;

    procedure report1("Docuent No": Code[20])
    var
        ProdgradesortingHdr: Record "product grade sorting header";
        Report_one: Report Report_one;
    begin
        // Message('%1', "Docuent No");
        ProdgradesortingHdr.Reset();
        ProdgradesortingHdr.SetRange("Document No", "Docuent No");
        if ProdgradesortingHdr.FindSet() then begin
            Report.RunModal(Report::Report_one, true, true, ProdgradesortingHdr);
        end;
    end;



}