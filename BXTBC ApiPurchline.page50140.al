page 50140 APIBXTBCPurchLine
{
    PageType = API;
    APIPublisher = 'BCPDA';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    UsageCategory = Administration;
    SourceTable = "Purchase Line";
    EntityCaption = 'BXTBCPurchLine';
    EntitySetCaption = 'BXTBCPurchLines';
    EntityName = 'BXTBCPurchLine';
    EntitySetName = 'BXTBCPurchLines';
    Extensible = false;
    DelayedInsert = true;
    ODataKeyFields = "Document Type", "Document No.", "Line No.";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("DocumentNo"; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    ApplicationArea = All;
                }
                field("LineNo"; Rec."Line No.")
                {
                    Caption = 'Line No.';
                    ApplicationArea = All;
                }
                field("ItemNo"; Rec."No.")
                {
                    Caption = 'ItemNo';
                    ApplicationArea = All;
                }
                field("Type"; Rec."Document Type")
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }

                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field("BuyfromVendorNo"; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;
                }
                field("QtytoReceive"; Rec."Qty. to Receive")
                {
                    Caption = 'Qty.toReceive';
                    ApplicationArea = All;
                }
                field("QuantityReceived"; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                    ApplicationArea = All;
                }
                field(Location; Rec."Location Code")
                {
                    Caption = 'Location';
                    ApplicationArea = All;
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

                trigger OnAction()
                begin

                end;
            }
        }
    }


    [ServiceEnabled]
    procedure BCPurchLineClone(): Text[50]
    var
        BXTPurchaseLine: Record "BXT Purchase Order Line";
        BCPurchaseLine: Record "Purchase Line";
        NewPurchLine: Record "Purchase Line";
        BCPurchHeader: Record "Purchase Header";
        BXTPurchaseHeader: Record "BXT Purchase Order Header";
        lineType: Enum "Purchase Line Type";
        isSuccess: Boolean;
        isFind: Boolean;
        isExist: Boolean;
        result: Text[50];
        Status: Enum "Purchase Document Status";
        Received: Decimal;
        Quantity: Decimal;
        DocType: Enum "Purchase Document Type";
        isGet: Boolean;
        docno: Code[20];
        lineno: Integer;
        docno2: Code[20];
        amount: Integer;
        isDelete: Boolean;
    begin
        BCPurchaseLine.SetRange(Type, lineType::Item);
        BCPurchaseLine.SetRange("Document Type", DocType::Order);
        isFind := BCPurchaseLine.FindSet();
        if isFind then begin
            repeat
                // BCPurchaseLine.Get(DocType::Order, 'PO000000226', 10000);
                Received := BCPurchaseLine."Quantity Received";
                Quantity := BCPurchaseLine.Quantity;
                BCPurchHeader.Get(DocType::Order, BCPurchaseLine."Document No.");
                isExist := BCPurchaseLine.Get(DocType::Order, BCPurchaseLine."Document No.", BCPurchaseLine."Line No.");
                result := 'no change';
                isGet := BXTPurchaseLine.Get(BCPurchaseLine."Document No.", BCPurchaseLine."Line No.");
                //isGet := BXTPurchaseLine.Get(DocType::Order, BCPurchaseLine."Document No.", BCPurchaseLine."Line No.");
                if isGet then begin
                    result := 'modified';
                    BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
                    BXTPurchaseLine.Description := BCPurchaseLine.Description;
                    BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
                    BXTPurchaseLine."Document No." := BCPurchaseLine."Document No.";
                    BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
                    if BCPurchHeader.Status = Status::Open then begin
                        BXTPurchaseLine."Qty. to Receive" := BXTPurchaseLine.Quantity - BXTPurchaseLine.CurrRece;
                    end;
                    if BCPurchHeader.Status = Status::Released then begin
                        BXTPurchaseLine."Qty. to Receive" := BCPurchaseLine.Quantity - BCPurchaseLine."Qty. to Invoice";
                    end;

                    BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
                    BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
                    isSuccess := BXTPurchaseLine.Modify();

                    if (Received = Quantity) then begin
                        BXTPurchaseLine."Line No." := BCPurchaseLine."Line No.";
                        BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
                        BXTPurchaseLine.Delete();
                    end;
                    BXTPurchaseLine.ClearMarks();
                end else begin
                    if (Received <> Quantity) then begin
                        BXTPurchaseLine."Line No." := BCPurchaseLine."Line No.";
                        BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
                        BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
                        BXTPurchaseLine.Description := BCPurchaseLine.Description;
                        BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
                        BXTPurchaseLine."Document No." := BCPurchaseLine."Document No.";
                        BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
                        BXTPurchaseLine."Qty. to Receive" := BXTPurchaseLine.Quantity - BXTPurchaseLine.CurrRece;
                        BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
                        BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
                        BXTPurchaseLine.Insert();
                        result := 'insert';
                        BXTPurchaseLine.ClearMarks();
                    end;
                end;
            until BCPurchaseLine.Next() = 0;
        end;


        BXTPurchaseLine.Reset();
        BXTPurchaseLine.SetRange("Document Type", lineType::Item);
        //BXTPurchaseLine.SetRange("Document No.", 'PO000000046');
        if BXTPurchaseLine.FindSet() then begin
            repeat
                docno := BXTPurchaseLine."Document No.";
                lineno := BXTPurchaseLine."Line No.";
                isExist := BCPurchaseLine.Get(DocType::Order, docno, lineno);
                if isExist then begin
                    //result := 'remain';
                end else begin
                    //result := 'Delete';
                    BXTPurchaseLine."Document No." := docno;
                    BXTPurchaseLine."Line No." := lineno;
                    BXTPurchaseLine.Delete();
                    BXTPurchaseLine.ClearMarks();
                end;

            until BXTPurchaseLine.Next() = 0;
        end;


        BXTPurchaseLine.Reset();
        BXTPurchaseHeader.SetRange("Document Type", DocType::Order);
        if BXTPurchaseHeader.FindSet() then begin
            repeat
                docno2 := BXTPurchaseHeader."No.";
                //docno2 := 'PO000000057';
                BXTPurchaseLine.SetRange("Document No.", docno2);
                amount := BXTPurchaseLine.Count;
                isFind := BXTPurchaseLine.FindSet();
                if not isFind then begin
                    BXTPurchaseHeader."No." := docno2;
                    BXTPurchaseHeader."Document Type" := DocType::Order;
                    isDelete := BXTPurchaseHeader.Delete();
                    Commit();
                    BXTPurchaseHeader.ClearMarks();
                end;
            until BXTPurchaseHeader.Next() = 0;

        end;
        exit(result);
    end;
}