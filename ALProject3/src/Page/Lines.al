page 90026 Lines
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "product grade sorting line";
    AutoSplitKey = true;
    RefreshOnActivate = true;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Defact item No."; Rec."Defact item No.")
                {
                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        producHeader: Record "product grade sorting header";
                        Item: Record Item;
                        ItemList: page "Item List";

                    begin
                        producHeader.Reset();
                        producHeader.SetRange("Document No", Rec."Document No");
                        if producHeader.FindSet() then begin
                            item.Reset();
                            item.SetCurrentKey("No."); // เลือกตารางสำหรับการใช้งาน คือ "No." ตารางที่ไม่ถูกใช้งานจะถูกละเว้น
                            item.setfilter("No.", '%1|%2', producHeader."Item C", producHeader."Item Scap"); // กำหนดตัวกรองให้กับฟิลด์ที่ระบุ 
                            // item.setfilter("No.", '%1|%2|%3', producHeader."Item A", producHeader."Item C", producHeader."Item Scap");  ออก 3 ตัว
                            if item.FindSet() then begin
                                item.Mark(true);
                            end;

                            itemList.LookupMode(true);
                            itemList.SetTableView(item);
                            if Page.RunModal(PAGE::"Item List", item) = Action::LookupOK then begin // เปิดหน้า Item List เมื่อต้องการปิดเพจ ให้กดปุ่มตกลง
                                text := item."No.";
                                Rec.Description := item.Description;
                                exit(true);
                            end
                        end;

                    end;

                    trigger OnValidate()
                    begin
                        errorline();
                    end;


                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        errorline();
                    end;
                }
                field("Defact Reason Code"; Rec."Defact Reason Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        errorline();
                    end;
                }
                field("Defact Daecription"; Rec."Defact Daecription")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        errorline();
                    end;
                }
                field("Defact Qty"; Rec."Defact Qty")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        errorline();
                    end;
                }
                field("Location Code"; Rec."Location Code")
                {
                    trigger OnValidate()
                    begin
                        errorline();
                    end;
                }
                field("References Production order"; Rec."References Production order")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        errorline();
                    end;

                }
            }
        }


    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    var
        ProductionOrder: Record "Production Order";


    procedure errorline()
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", Rec."Document No");
        ProductionOrder.SetRange("References Line No", Rec."Line No");
        if ProductionOrder.FindSet() then begin
            // Error('ไม่สามารถแก้ไขเอกสารได้เพราะถูกสร้างไปแล้ว');
            Error('The document cannot be edited because it has already been created.');
            // Error('Unable to edit, this document has already been created.');
        end;
    end;

    procedure checkgradelist("Document No": Code[20])
    var
        productgradesortingline: Record "product grade sorting line";
    begin
        productgradesortingline.Reset();
        productgradesortingline.SetRange("Document No", "Document No");
        if productgradesortingline.FindSet() then begin
            Error('กรอกให้ครบ');
        end;
    end;


}