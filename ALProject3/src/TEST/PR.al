
// // trigger OnInsert()
// // begin
// //     if "Document No" = '' then begin // ถ้า Document เป็นค่าว่าง 
// //         InvenSetup.Get();
// //         InvenSetup.TestField("Document No"); // ทดสอบว่าข้อมูลตรงกันไหม
// //         NoSeriesMgt.InitSeries(InvenSetup."Document No", xRec."No.Series", 0D, "Document No", "No.Series"); //ก็ไปทำฟังชั่น get doc no ใน no series
// //     end;
// //     InitRecord();
// // end;

// // trigger OnModify()
// // var

// // begin

// // end;


// // procedure InitRecord() // ใช้ข้างนอกและข้างในได้  InitRecord เริ่มต้นการบัทึกลงตาราง
// // begin
// //     "Document Date" := WorkDate();
// // end;

// // procedure AssistEdit(OldCertofAnalysis: Record "product grade sorting header"): Boolean
// // begin
// //     InvenSetup.Get(); // เรียกใช้ฟังชั่น ให้ get ข้อมูลใน inventory setup โดยใช้คำสั่ง get
// //     TestNoSeries(); // จากนั้นให้ไปเข้าฟังชั่น TestNoseries
// //     if NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldCertofAnalysis."No.Series", "No.Series") then begin // ถ้าเข้าเงื่อนไขก็นำ noseries มาใส่
// //         TestNoSeries();
// //         NoSeriesMgt.SetSeries("Document No");
// //         exit(true);
// //     end;
// // end;

// // local procedure TestNoSeries() // ใช้ได้แค่ภายใน
// // begin
// //     InvenSetup.TestField("Document No"); // มันจะทำการ testfield ว่ามันmatch กันไหม ละอาข้อมูลมา
// // end;

// // local procedure GetNoSeriesCode(): Code[20]
// // begin
// //     exit(InvenSetup."Document No"); // ตรงนี้คือจังหวะเอา no series มาใสใน Document No
// // end;


// // var
// //     productgradesortingline: Record "product grade sorting line";
// //     // Mycode: Codeunit "My Codeunit";
// // begin
// //     productgradesortingline.Reset();
// //     productgradesortingline.SetRange("Document No", Rec."Document No");
// //     if productgradesortingline.FindSet() then begin
// //         repeat
// //             ProductionOrder.Reset();
// //             ProductionOrder.SetRange("References Document No", productgradesortingline."Document No");
// //             ProductionOrder.SetRange("References Line No", productgradesortingline."Line No");
// //             if not ProductionOrder.FindSet() then begin
// //                 Message('%1', productgradesortingline);
// //             end;
// //         until productgradesortingline.Next() = 0;

// //     end;
// //     Mycode.CreateProdOrder(Rec."Document No");
// // end;

// //  SalesLine.Reset();
// //         SalesLine.SetRange("Document Type", rec."Document Type");
// //         SalesLine.SetRange("Document No.", rec."Document No.");
// //         if SalesLine.FindSet() then begin
// //             repeat
// //                 Total += SalesLine."Amount1";
// //             until SalesLine.Next() = 0;
// //         end;

// //         SalesHeader.Reset();
// //         SalesHeader.SetRange("Document Type", Rec."Document Type");
// //         SalesHeader.SetRange("No.", Rec."Document No.");
// //         if SalesHeader.FindSet() then begin
// //             SalesHeader.Amount2 := Total;
// //             SalesHeader.Modify();
// //         end;
// //     end;




// // TmpItemJnlLn.Init();
// //   TmpItemJnlLn.Validate("Journal Template Name", MfgSetup."Output Journal Template");
// //   TmpItemJnlLn.Validate("Journal Batch Name", MfgSetup."Output Journal Batch");
// //   TmpItemJnlLn."Line No." := LineNo;
// //   TmpItemJnlLn.Insert();
// //   TmpItemJnlLn.Validate("Entry Type", TmpItemJnlLn."Entry Type"::Output);
// //   TmpItemJnlLn.Validate("Posting Date", WorkDate());
// //   TmpItemJnlLn.Validate("Order No.", ProdOrdCGrade."No.");
// //   TmpItemJnlLn.Validate("Item No.", ProdOrdCGrade."Source No.");

// //   ProdOrdRtngLn.Reset();
// //   ProdOrdRtngLn.SetCurrentKey(Status, "Prod. Order No.");
// //   ProdOrdRtngLn.SetRange(Status, ProdOrdRtngLn.Status::Released);
// //   ProdOrdRtngLn.SetRange("Prod. Order No.", ProdOrdCGrade."No.");
// //   ProdOrdRtngLn.SetRange("Next Operation No.", '');
// //   if ProdOrdRtngLn.FindSet() then
// //       TmpItemJnlLn.Validate("Operation No.", ProdOrdRtngLn."Operation No.");
// //   TmpItemJnlLn.Validate("Location Code", MfgSetup."Default Location Code");
// //   TmpItemJnlLn.Validate("Output Quantity", ProdOrdCGrade.Quantity);
// //   TmpItemJnlLn.Modify();
// //   LineNo += 10000;


// report 90006 Report_TWo
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC; // ระบุว่ารายงานใช้โครงร่างรายงาน RDL หรือ Word ในตัวตามค่าเริ่มต้นหรือไม่
//     RDLCLayout = 'Layouts/report_two.rdl'; // ตั้งค่าเค้าโครง RDL ที่ใช้ในรายงานและส่งกลับเป็นสตรีมข้อมูล

//     dataset
//     {
//         dataitem(SalesHeader; SalesHeader)//level 1
//         {
//             column(OutputNo; OutputNo) { }
//             column(No_; "No.") { }
//             column(VAT_RegistrationNo; CompanyInfo."VAT Registration No.") { }
//             column(City_H; SalesHeader.City) { }
//             column(No_H; SalesHeader."No.") { }
//             column(Document_Date_H; SalesHeader."Document Date") { }
//             column(Vendor_Name_H; SalesHeader."Vendor Name") { }
//             column(Vendor_Number_H; SalesHeader."Vendor Number.") { }
//             column(Shipment_Date_H; SalesHeader."Shipment Date") { }
//             column(Amount1_H; SalesHeader.Amount1) { }
//             column(Address_H; SalesHeader.Address) { }
//             column(Contact_H; SalesHeader.Contact) { }
//             column(VAT_Registration_No; SalesHeader."VAT Registration No") { }

//             //------------------------------------------- เลขบัตร 13 หลัก
//             column(Card1; CardNumber[1]) { }
//             column(Card2; CardNumber[2]) { }
//             column(Card3; CardNumber[3]) { }
//             column(Card4; CardNumber[4]) { }
//             column(Card5; CardNumber[5]) { }
//             column(Card6; CardNumber[6]) { }
//             column(Card7; CardNumber[7]) { }
//             column(Card8; CardNumber[8]) { }
//             column(Card9; CardNumber[9]) { }
//             column(Card10; CardNumber[10]) { }
//             column(Card11; CardNumber[11]) { }
//             column(Card12; CardNumber[12]) { }
//             column(Card13; CardNumber[13]) { }
//             column(CardNumber_No; SalesHeader."VAT Registration No") { }
//             column(CompanyName; "Companyname") { }
//             column(Picture_Company; CompanyInfo.Address) { }
//             column(BankAccount; CompanyBankAccount.Address) { }
//             column(CopyText_H; CopyText) { }


//             // column(typereport; typereport) { }
//             // column(Companyname_Company; CompanyInfo.Companyname)
//             //----------------------------------------------------------------------

//             dataitem(CopyLoop; "Integer")//level 2
//             {
//                 DataItemTableView = sorting(Number); // Sorting การจัดเรียงช่วยให้คุณเห็นภาพรวมอย่างรวดเร็วของข้อมูลได้ง่าย เช่นการที่มีจำนวนที่เยอะ
//                 column(Number; Number) { }
//                 // column(typereport; typereport) { }
//                 dataitem(pageLoop; "Integer")//level 3
//                 {
//                     DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
//                     dataitem(daitemline; "Integer")
//                     {
//                         DataItemTableView = SORTING(Number) WHERE(Number = filter(1 ..));

//                         // ข้อมูบของ SalesLine
//                         column(No_L; TempSalesLine."No.") { }
//                         column(Quantity_L; TempSalesLine.Quantity) { }
//                         column(Price_L; TempSalesLine.Price) { }
//                         column(Description_L; TempSalesLine."Description") { }
//                         column(Amount1_L; TempSalesLine.amount1) { }
//                         column(Shipment_Date; TempSalesLine."Shipment Date") { }
//                         column(CopyText; CopyText) { }
//                         column(typereport; typereport) { }

//                         trigger OnPreDataItem() //OnPreDataItem ถูกดำเนินการก่อนที่รายการข้อมูลจะถูกประมวลผล 
//                         var
//                         begin
//                             TempSalesLine.Reset();
//                         end;

//                         trigger OnAfterGetRecord() // OnAfterRecord ดำเนินการหลังจากเรียกระเบียนจากตาราง แต่ก่อนที่จะแสดงต่อผู้ใช้
//                         begin
//                             if Number = 1 then begin
//                                 if not TempSalesLine.FindSet() then begin
//                                     CurrReport.Break();
//                                 end;

//                             end else begin
//                                 if TempSalesLine.Next = 0 then begin
//                                     CurrReport.Break();
//                                 end;
//                             end;
//                         end;
//                     }
//                     // 8.4	ให้ตีเส้นข้าง Report ใช้ Integer ในการ Run แถวว่างให้เต็มหน้า
//                     dataitem(emptyline; "Integer")
//                     {
//                         column(dataline; Number) { }
//                         trigger OnPreDataItem()
//                         var
//                             dataline1: Integer;
//                             endline: Integer;

//                         begin
//                             TempSalesLine.Reset();
//                             if TempSalesLine.FindSet() then begin
//                                 dataline1 := TempSalesLine.Count;
//                             end;
//                             endline := 29;
//                             repeat
//                                 if endline < dataline1 then begin
//                                     endline += 29;
//                                 end;
//                             until endline > dataline1;
//                             SetRange(Number, dataline1, endline - 1);
//                         end;
//                     }
//                 }


//                 trigger OnAfterGetRecord();
//                 begin
//                     if Number > 1 then begin
//                         CopyText := FormatDocument.GetCOPYText;
//                         OutputNo += 1;
//                         typereport := 'Copy';
//                     end;

//                 end;

//                 trigger OnPreDataItem();
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                     typereport := 'Original';
//                 end;
//             }

//             // 8.5	ใช้ Temporary ในการทำ Report ใบซื้อสินค้าโดย Group Item ที่ซ้ำกัน , Group ราคา เดียวกัน
//             trigger OnAfterGetRecord()
//             var
//                 salesline1: Record SalesLine;
//             begin
//                 TempSalesLine.Reset();
//                 TempSalesLine.DeleteAll();
//                 salesline1.Reset();
//                 salesline1.SetRange("Document No.", SalesHeader."No.");
//                 if salesline1.FindSet() then begin
//                     repeat
//                         TempSalesLine.Reset();
//                         TempSalesLine.SetCurrentKey("Document Type", "type", "Document No.");
//                         TempSalesLine.SetRange("Document Type", salesline1."Document Type");
//                         TempSalesLine.SetRange(Type, salesline1.Type);
//                         TempSalesLine.SetRange("Document No.", salesline1."Document No.");

//                         // TempSalesLine.SetRange("Line No.", salesline1."Line No.");
//                         TempSalesLine.SetRange("No.", salesline1."No.");
//                         //TempSalesLine.SetRange("Line No.", salesline."Line No.");
//                         if not TempSalesLine.FindSet() then begin
//                             TempSalesLine.Init();
//                             TempSalesLine."Document Type" := salesline1."Document Type";
//                             TempSalesLine.Type := salesline1.Type;
//                             TempSalesLine."Document No." := salesline1."Document No.";
//                             TempSalesLine."Line No." := salesline1."Line No.";
//                             TempSalesLine."No." := salesline1."No.";
//                             TempSalesLine."Description" := salesline1."Description";
//                             TempSalesLine.Quantity := salesline1.Quantity;
//                             TempSalesLine.Price := salesline1.Price;
//                             TempSalesLine.Amount1 := salesline1.Amount1;
//                             TempSalesLine."Shipment Date" := salesline1."Shipment Date";
//                             TempSalesLine.Insert();
//                         end else begin
//                             TempSalesLine.Quantity += salesline1.Quantity;
//                             TempSalesLine.Amount1 += salesline1.Amount1;
//                             TempSalesLine.Modify();
//                         end;
//                     until salesline1.Next() = 0;

//                     // TempSalesLine.Reset();
//                 end;
//             end;
//         }

//     }
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field(NoOfCopies; NoOfCopies) /// ---- ส่วนช่องที่เอาไว้กรอกข้อมูล
//                     {
//                         ApplicationArea = All;
//                         Caption = 'NoOfCopy_Changecopy';

//                     }
//                 }
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }


//     trigger OnInitReport() // OnInitReport --> ทำงานเมื่อโหลดรายงาน
//     begin
//         CompanyInfo.Get;
//         CompanyInfo.CalcFields(Picture);
//     end;

//     trigger OnPreReport()
//     begin
//         // TempSalesLine.DeleteAll();

//         FOR i := 1 TO STRLEN(CompanyInfo."VAT Registration No.") DO
//             CardNumber[i] := COPYSTR(CompanyInfo."VAT Registration No.", i, 1);
//     end;

//     var
//         a: Integer;
//         b: Integer;
//         CompanyInfo: Record "Company Information";
//         CompanyBankAccount: Record "Bank Account";
//         CardNumber: array[13] of Code[20];
//         i: Integer;

//         Position: Integer; //เก็บข้อมูลบัตรประชาชน
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         CopyText: Text[30];
//         OutputNo: Integer;
//         FormatDocument: Codeunit "Format Document";
//         SumAmount: Decimal;
//         IndexPage: Integer;
//         CountPageOneDoc: Integer;

//         AmountText: text[100];
//         CountLineCheckDoc: Integer;
//         TempSalesLine: Record SalesLine temporary;
//         typereport: Text[20];

//     //OnInitReport:ทำงานพร้อมกับการโหลดรายงาน
//     //OnPreReport:ทำงานก่อนการรันรายงาน
//     //OnPostReport:ทำงานหลังการรันรายงาน
//     // Bank_Report_Title: Label 'Bank Account Report';
//     // OnPredataItem ถูกดำเนินการก่อนที่รายการข้อมูลจะถูกประมวลผล 
// }
