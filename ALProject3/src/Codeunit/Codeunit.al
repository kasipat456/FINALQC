codeunit 90000 "My Codeunit" // 
{
    trigger OnRun()
    begin
        // num1 := 2;
        // num2 := 3;
        // add(num1, num2);
        // RPO()
    end;


    procedure CreateProdOrder("Document H": Code[20]) // ส่ง Document No ของ Header
    var
        productgradesortingheader: Record "product grade sorting header";
        productgradesortingline: Record "product grade sorting line";
        ProductionOrder: Record "Production Order";
        NoSeriesLine: Record "No. Series Line";
        refreshproductionorderline: Codeunit "Create Prod. Order Lines";
        Direction: Option Forward,Backward;

    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", "Document H"); // หาค่า Document No ที่เหมือนกัน F-QC
        productgradesortingline.SetFilter("References Production order", '%1', ''); // หาค่า ถ้า References Production order 

        if productgradesortingline.FindSet() then begin
            repeat
                ProductionOrder.Reset();
                ProductionOrder.SetRange("References Document No", productgradesortingline."Document No"); // หาค่า F-QC
                ProductionOrder.SetRange("References Line No", productgradesortingline."Line No"); // หาค่า บรรทัดไลน์ 10000,20000,..


                if not ProductionOrder.FindSet() then begin // ถ้าไม่เจอใบสั้งผลิต ให้ทำการสร้างใบสั้งผลิต
                    ProductionOrder.Init();
                    ProductionOrder.Status := ProductionOrder.Status::Released;
                    ProductionOrder."No." := NoSeriesLine."Last No. Used";
                    ProductionOrder."References Document No" := "Document H";
                    ProductionOrder."Source No." := productgradesortingline."Defact item No.";
                    ProductionOrder."Creation Date" := Today;
                    ProductionOrder."Description" := productgradesortingline.Description;
                    ProductionOrder."Search Description" := productgradesortingline.Description;
                    ProductionOrder.Quantity := productgradesortingline."Defact Qty";
                    ProductionOrder."References Document No" := productgradesortingline."Document No";
                    ProductionOrder."References Line No" := productgradesortingline."Line No";
                    ProductionOrder."Defact Daecription" := productgradesortingline."Defact Daecription";
                    ProductionOrder."Location Code" := productgradesortingline."Location Code";



                    ProductionOrder.Insert(true);
                    refreshproductionorderline.Copy(ProductionOrder, Direction, ProductionOrder."Variant Code", false);

                    productgradesortingline."References Production order" := ProductionOrder."No."; // ของใบสั่งผลิต
                    productgradesortingline.Modify();
                end else begin // ถ้าเจอใบสั้งผลิต ให้้ ERROR ว่ามีใบสั้งผลิตอยู๋แล้ว
                    Error('เอกสาร %1 อยู่ในใบสั่งผลิต %2', productgradesortingline."Document No", ProductionOrder."No.");
                end;
            until productgradesortingline.Next() = 0;
            // Message('เอกสาร %1 ใบสั้งผลิตที่ %2 \\ เอกสารถูกสร้างเรียบร้อย', productgradesortingline."Document No", ProductionOrder."No.");
            Message('Post บันทึกรายการเสร็จเรียบร้อยแล้ว');
        end;
    end;



    procedure Createoutput("Document H": Code[20])
    var
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ItemJournalLine: Record "Item Journal Line"; // Output Journal
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        lineno: Integer;
        test1: Text;
        test2: Text;
        test3: text;
        test4: Text;
    begin
        lineno := 0;
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", "Document H"); // หาค่าของเลขที่ใบเอกสาร
        if ProductionOrder.FindSet() then begin
            Message('1');
            repeat
                ItemJournalLine.Reset();
                ItemJournalLine.SetRange("Order No.", ProductionOrder."No.");
                ItemJournalLine.SetRange("Journal Template Name", 'OUTPUT');
                ItemJournalLine.SetRange("Journal Batch Name", 'DEFAULT');

                if not ItemJournalLine.FindSet() then begin
                    Message('2');

                    lineno += 10000;
                    ItemJournalLine.Init();


                    ItemJournalLine."Journal Template Name" := 'OUTPUT';
                    ItemJournalLine."Journal Batch Name" := 'DEFAULT';
                    ItemJournalLine."Order No." := ProductionOrder."No.";
                    ItemJournalLine.Validate(Description, ProductionOrder.Description);
                    ItemJournalLine.Validate("Document No.", ProductionOrder."No.");
                    ItemJournalLine.Validate("Posting Date", ProductionOrder."Due Date");
                    ItemJournalLine.Validate("Item No.", ProductionOrder."Source No.");
                    ItemJournalLine.Validate("Location Code", ProductionOrder."Location Code");
                    ItemJournalLine."Output Quantity" := ProductionOrder.Quantity;
                    //   ItemJournalLine."Routing No."


                    ProdOrderRoutingLine.Reset();
                    ProdOrderRoutingLine.SetRange("Prod. Order No.", ItemJournalLine."Order No.");
                    ProdOrderRoutingLine.SetRange(Type, ItemJournalLine.Type);
                    if ProdOrderRoutingLine.FindSet() then begin
                        Message('3');
                        ItemJournalLine."Routing No." := ProdOrderRoutingLine."Routing No.";
                        ItemJournalLine."Cap. Unit of Measure Code" := ProdOrderRoutingLine."Move Time Unit of Meas. Code";
                        ItemJournalLine."No." := 'WC-001';
                        ItemJournalLine."Operation No." := '100';

                        // ItemJournalLine.Validate("Routing No.", ProdOrderRoutingLine."Routing No.");
                        // ItemJournalLine.Validate("Cap. Unit of Measure Code", ProdOrderRoutingLine."Move Time Unit of Meas. Code");
                        // test1 := ProdOrderRoutingLine."Routing No.";
                        // test2 := ProdOrderRoutingLine."Move Time Unit of Meas. Code";
                        // test4 := ProdOrderRoutingLine."Operation No.";
                        // test3 := ProdOrderRoutingLine."No.";


                    end;
                    // ItemJournalLine."Routing No." := test1;
                    // ItemJournalLine."Cap. Unit of Measure Code" := test2;
                    // ItemJournalLine."Operation No." := test4;
                    // ItemJournalLine."No." := test3;
                    // ItemJournalLine.Type := ProdOrderRoutingLine.Type::"Work Center";

                    // Error('%1', test1);
                    Message('%1 test op no', test1);


                    ProdOrderLine.Reset();
                    ProdOrderLine.SetRange("Prod. Order No.", ItemJournalLine."Order No.");
                    ProdOrderLine.SetRange("Item No.", ItemJournalLine."Item No.");
                    if ProdOrderLine.FindSet() then begin
                        Message('4');

                        ItemJournalLine.Validate("Order Line No.", ProdOrderLine."Line No.");
                        ItemJournalLine.Validate("Item No.", ProdOrderLine."Item No.");


                        ItemJournalLine."Line No." := lineno;
                        // ItemJournalLine.Modify();
                    end;
                    ItemJournalLine.Insert();
                    ItemJournalLine.Modify();
                    // ItemJournalLine.Insert(true);
                end;

            until ProductionOrder.Next() = 0;
            Message('Complete Output');
        end;
    end;






}