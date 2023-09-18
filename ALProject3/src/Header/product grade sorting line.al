table 90011 "product grade sorting line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Defact item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Defact Reason Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                ReasonCode.Reset();
                if ReasonCode.Get("Defact Reason Code") then begin
                    Validate("Defact Daecription", ReasonCode.Description);
                end;
            end;
        }
        field(6; "Defact Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
                defactqty();
            end;
        }
        field(7; "Defact Daecription"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "References Production order"; Code[100])
        {
            Caption = 'References Production order';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; "Location Code"; code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(11; "No"; code[20])
        {
            Caption = 'No';
        }
    }

    keys
    {
        key(Key1; "Document No", "Line No")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesLine: Record "No. Series Line";
        NoSeries: Record "No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;


    trigger OnInsert()
    var

    begin

    end;

    trigger OnModify() // ห้ามแก้ไขไลน์
    begin

    end;


    trigger OnDelete() // ห้ามลบ LIne 
    var
        ProductionOrder: Record "Production Order";

    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange("References Document No", "Document No");
        ProductionOrder.SetRange("References Line No", "Line No");
        if ProductionOrder.FindSet() then begin
            // Error('ไม่สามรถลบไลน์ได้เพราะเอกสารถูกสร้างไปแล้ว');
            Error('The line cannot be deleted because the document has already been created.');
            // Error('cannot be deleted because it has already been created');
        end;

    end;

    trigger OnRename()
    begin

    end;

    procedure insertNoSeries()
    var
        ProdgradesortingLn: Record "product grade sorting line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin

    end;

    procedure defactqty()
    var
        ProdgradesortingLn: Record "product grade sorting line";
        ProdgradesortingHdr: Record "product grade sorting header";
        total: Decimal;
        totalgradec: Decimal;
        totalscap: Decimal;
        totalgradescap: Decimal;
        scap: Decimal;
        scap1: Decimal;

    begin
        ProdgradesortingHdr.Reset();
        ProdgradesortingHdr.SetRange("Document No", Rec."Document No");
        ProdgradesortingHdr.SetRange("Document Date");
        if ProdgradesortingHdr.FindSet() then begin

            Clear(totalgradec);
            Clear(totalscap);
            Clear(totalgradescap);
            Clear(total);
            ProdgradesortingLn.Reset();
            ProdgradesortingLn.SetRange("Document No", Rec."Document No");
            if ProdgradesortingLn.FindSet() then begin
                repeat
                    if ProdgradesortingLn."Defact item No." = ProdgradesortingHdr."Item C" then begin // ดูว่า Item C มันตรงกันไหม

                        total += ProdgradesortingLn."Defact Qty"; // 
                    end;

                    if ProdgradesortingLn."Defact item No." = ProdgradesortingHdr."Item Scap" then begin
                        totalscap += ProdgradesortingLn."Defact Qty";
                    end;

                until ProdgradesortingLn.Next() = 0;

                if ProdgradesortingLn."Defact item No." = ProdgradesortingHdr."Item C" then begin // Item ที่เลือกตรงกับ Item Grade C ไหม
                    totalgradec := total + Rec."Defact Qty";
                    // Message('%1', totalgradec);
                end;

                if ProdgradesortingLn."Defact item No." = ProdgradesortingHdr."Item Scap" then begin // Item ที่เลือกตรงกับ Item Grade Scap ไหม
                    totalgradescap := totalscap + Rec."Defact Qty";
                end;
            end;
            if ProdgradesortingHdr.FindSet() then begin
                if totalgradec > ProdgradesortingHdr."Grade C number" then begin
                    Message('จำนวน C เกินไม่สามารถกรอกได้');
                    deleteLine(Rec."Document No", Rec."Line No");
                end;
            end;

            if totalgradescap > ProdgradesortingHdr."Grade Scap number" then begin
                Message('จำนวน Scap เกินไม่สามารถกรอกได้');
                deleteLine(Rec."Document No", Rec."Line No");
            end;
        end;

    end;


    procedure deleteLine("Document No": code[20]; "Line No": Integer)
    var
        ProdgradesortingLn: Record "product grade sorting line";
    begin
        ProdgradesortingLn.Reset();
        ProdgradesortingLn.SetRange("Line No", "Line No");
        ProdgradesortingLn.SetRange("Document No", "Document No");
        if ProdgradesortingLn.FindFirst() then begin
            ProdgradesortingLn.Delete();
        end;

    end;



}