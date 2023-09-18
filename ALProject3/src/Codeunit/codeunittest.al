codeunit 90001 "production sorting"
{
    trigger OnRun()
    begin
        // num1 := 2;
        // num2 := 3;
        // add(num1, num2);
        // RPO()
    end;


    procedure CreateProdOrder("Document No": Code[20]) // ส่ง Document No ของ Header
    var
        productgradesortingline: Record "product grade sorting line";
        ProductionOrder: Record "Production Order";
        NoSeriesLine: Record "No. Series Line";
        refreshproductionorderline: Codeunit "Create Prod. Order Lines";
        Direction: Option Forward,Backward;

    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", "Document No"); // หาค่า Document No ที่เหมือนกัน F-QC
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
                    ProductionOrder."References Document No" := "Document No";
                    ProductionOrder."Source No." := productgradesortingline."Defact item No.";
                    ProductionOrder."Creation Date" := Today;
                    ProductionOrder."Description" := productgradesortingline.Description;
                    ProductionOrder."Search Description" := productgradesortingline.Description;
                    ProductionOrder.Quantity := productgradesortingline."Defact Qty";
                    ProductionOrder."References Document No" := productgradesortingline."Document No";
                    ProductionOrder."References Line No" := productgradesortingline."Line No";
                    ProductionOrder."Defact Daecription" := productgradesortingline."Defact Daecription";


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

    procedure CreateOutPut1("Document H": Code[20]) // ส่งค่า หมายเลขเอกสารคัดแยกสินค้า 
    var
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ItemJournalLine: Record "Item Journal Line"; // Output Journal
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        InventorySetup: Record "Inventory Setup";
        lineno: Integer;
        ProdgradesortingHdr: Record "product grade sorting header";
        ItemJnlPost: Codeunit "Item Jnl.-Post Batch";
    begin
        InventorySetup.Get();
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", "Document H"); // เอาหมายเลขเอกสารคัดแยกสินค้ามาหากัน
        if ProductionOrder.FindSet() then begin
            repeat
                // lineno += 10000;
                ItemJournalLine.Init();
                ItemJournalLine.Validate("Journal Template Name", InventorySetup."Journal Template Name");
                ItemJournalLine.Validate("Journal Batch Name", InventorySetup."Journal Batch Name");
                ItemJournalLine."Line No." := lineno; // line + 10000
                ItemJournalLine.Insert();
                ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::Output);
                ItemJournalLine.Validate("Posting Date", WorkDate()); // วันที่
                ItemJournalLine.Validate("Order No.", ProductionOrder."No.");  // เลขใบสั้งผลิต
                ItemJournalLine.Validate("Item No.", ProductionOrder."Source No."); // ชื่อไอเทม

                ProdOrderRoutingLine.Reset();
                ProdOrderRoutingLine.SetCurrentKey(Status, "Prod. Order No."); // สถานะของเอกสาร , เลบใบสั้งผลิต เพื่อเรียงลำดับเนื้อหาของตารางในฟิลด์
                ProdOrderRoutingLine.SetRange(Status, ProdOrderLine.Status::Released);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrder."No.");  // เลขใบสั้งผลิต
                ProdOrderRoutingLine.SetRange("Next Operation No.", '');
                if ProdOrderRoutingLine.FindSet() then
                    ItemJournalLine.Validate("Operation No.", ProdOrderRoutingLine."Operation No.");

                ItemJournalLine.Validate("Location Code", ProductionOrder."Location Code");
                // ItemJournalLine.Validate("Location Code", InventorySetup."Default Location Code");
                ItemJournalLine.Validate("Output Quantity", ProductionOrder.Quantity); // จำนวนไอเทม

                lineno += 10000;

                ItemJournalLine.Modify();

            until ProductionOrder.Next() = 0;
            Message('Successfully created');

        end;
        clear(ItemJnlPost);
        ItemJnlPost.Run(ItemJournalLine);
    end;





}