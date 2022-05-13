page 50137 "API BXT Purchase Order Line"
{
    PageType = API;
    APIPublisher = 'BCPDA';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    EntityCaption = 'BXTPurchaseOrderLine';
    EntitySetCaption = 'BXTPurchaseOrderLines';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'BXTPurchaseOrderLine';
    EntitySetName = 'BXTPurchaseOrderLines';
    SourceTable = "BXT Purchase Order Line";
    Extensible = false;
    ODataKeyFields = "Document No.", "Line No.";
    Editable = true;

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
                field("ItemNo"; Rec."Item No.")
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
                field(Location; Rec.Location)
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                }
                field(UserID; Rec.UserID)
                {
                    Caption = 'UserID';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
                field(CurrRece; Rec.CurrRece)
                {
                    Caption = 'CurrRece';
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
    procedure ModifyQtyToReceive(documentno: Code[20]; lineno: Integer; qtytoreceive: Decimal): Boolean
    var
        BXTOrderLine: Record "BXT Purchase Order Line";
        BCOrderLine: Record "Purchase Line";
        BCPurchHeader: Record "Purchase Header";
        result: Text[20];
        DocType: Enum "Purchase Document Type";
        isBCSuccess: Boolean;
        isBXTSuccess: Boolean;
        isModify: Boolean;
        Doc: Code[20];
        LINE: Integer;
        Status: Enum "BXT Purchline Status";
        DocStatus: Enum "Purchase Document Status";
        DocLineType: Enum "Purchase Line Type";
        BXTPurchaseHeader: Record "BXT Purchase Order Header";
        remain: Decimal;
    begin

        BXTOrderLine.SetRange("Document Type", DocLineType::Item);
        isBXTSuccess := BXTOrderLine.Get(DocumentNo, LineNo);
        isBCSuccess := BCOrderLine.Get(DocType::Order, DocumentNo, LineNo);
        if isBXTSuccess and isBCSuccess then begin
            //remain := BXTOrderLine."Qty. to Receive";
            //BXTOrderLine.Validate("Qty. to Receive", QtyToReceive);
            //BXTOrderLine.Validate(CurrRece, QtyToReceive);

            BXTOrderLine.Status := Status::modified;
            BXTOrderLine.CurrRece += QtyToReceive;
            BXTOrderLine."Qty. to Receive" -= QtyToReceive;
            BCPurchHeader.Get(DocType::Order, BXTOrderLine."Document No.");
            // if BCPurchHeader.Status = DocStatus::Open then begin
            //     BXTOrderLine."Qty. to Receive" := BXTOrderLine.Quantity - BXTOrderLine.CurrRece;
            // end;
            // if BCPurchHeader.Status = DocStatus::Released then begin
            //     BXTOrderLine."Qty. to Receive" := BCOrderLine.Quantity - BCOrderLine."Qty. to Invoice";
            // end;

            BXTOrderLine.Modify();
            BCOrderLine.Validate("Qty. to Receive", BXTOrderLine.CurrRece);
            BCOrderLine.Modify();
            Commit();
        end;
        exit(isModify);
    end;

    [ServiceEnabled]
    procedure PurchPost(documentno: Code[20]): Text[200]
    var
        BXTPurchaseLine: Record "BXT Purchase Order Line";
        BCPurchaseLine: Record "Purchase Line";
        BCPurchaseHeader: Record "Purchase Header";
        InvoiceHeader: Record "Purchase Header";
        PurchPost: Codeunit "Purch.-Post";
        BXTPurchaseHeader: Record "BXT Purchase Order Header";
        DocType: Enum "Purchase Document Type";
        lineType: Enum "Purchase Line Type";
        isSuccessGET: Boolean;
        isSuccessRun: Boolean;
        ismodify: Boolean;
        ismodify2: Boolean;
        isFind: Boolean;
        message: Text[200];
        statusHeader: Enum "Purchase Document Status";
        statusLine: Enum "BXT Purchline Status";
        isGet: Boolean;
        isDelete: Boolean;

    begin

        BCPurchaseHeader.SetRange("Document Type", DocType::Order);
        BCPurchaseHeader.SetRange("No.", DocumentNo);
        isSuccessGET := BCPurchaseHeader.Get(DocType::Order, DocumentNo);//find bc po 
        BCPurchaseHeader.Receive := true;
        BCPurchaseHeader.SetHideValidationDialog(true);


        BXTPurchaseLine.SetRange("Document No.", DocumentNo);//find bxt po
        BXTPurchaseLine.SetRange(Status, statusLine::notChange);

        isFind := BXTPurchaseLine.FindSet();
        if isFind then begin
            repeat
                //BXTPurchaseLine.Validate("Qty. to Receive", 0);
                //BXTPurchaseLine.Modify();
                //modify to zero before posting
                if BCPurchaseLine.Get(DocType::Order, DocumentNo, BXTPurchaseLine."Line No.") then begin
                    BCPurchaseLine.Validate("Qty. to Receive", 0);
                    ismodify := BCPurchaseLine.Modify();
                    //message := 'modify seccessfully before posting';
                    Commit();
                end;
            until BXTPurchaseLine.Next() = 0;
            isSuccessRun := PurchPost.Run(BCPurchaseHeader);
            if isSuccessRun and isSuccessGET then begin
                message := 'Post successfully';
                //GetReceipts.SetPurchHeader();
            end;
        end else begin
            isSuccessRun := PurchPost.Run(BCPurchaseHeader);
            if isSuccessRun and isSuccessGET then begin
                message := 'Post successfully';
                //GetReceipts.SetPurchHeader();
            end;

        end;

        BXTPurchaseLine.Reset();
        BXTPurchaseLine.SetRange("Document No.", DocumentNo);
        if BXTPurchaseLine.FindSet() then begin
            repeat
                isGet := BCPurchaseLine.Get(DocType::Order, DocumentNo, BXTPurchaseLine."Line No.");
                if isGet then begin
                    BXTPurchaseLine.Validate("Qty. to Receive", BCPurchaseLine."Qty. to Receive");
                    BXTPurchaseLine.Validate(Status, statusLine::notChange);
                    BXTPurchaseLine.Validate(CurrRece, 0);
                    BXTPurchaseLine.Modify();
                    BCPurchaseLine.Validate("Qty. to Receive", 0);
                    ismodify2 := BCPurchaseLine.Modify();
                    //message += 'modify seccessfully after posting';
                    Commit();
                end;
            until BXTPurchaseLine.Next() = 0;
        end;

        BXTPurchaseHeader.Get(DocType::Order, DocumentNo);
        exit(message);
    end;

    [ServiceEnabled]
    procedure PurchaseLineClone(): Text[50]
    var
        BXTPurchaseLine: Record "BXT Purchase Order Line";
        BCPurchaseLine: Record "Purchase Line";
        NewPurchLine: Record "Purchase Line";
        BCPurchHeader: Record "Purchase Header";
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
        test: Code[20];
        test2: Integer;
        isDelete: Boolean;
        docno: Code[20];
        lineno: Integer;
    begin
        //test := 'PO000000037';

        // BCPurchaseLine.SetRange(Type, lineType::Item);
        // BCPurchaseLine.Get(DocType::Order, Rec."Document No.", Rec."Line No.");
        // NewPurchLine.Init();
        // NewPurchLine.TransferFields(BCPurchaseLine, false);
        // NewPurchLine.Insert();
        // actionContext.SetObjectType(ObjectType::Page);
        // actionContext.SetObjectId(Page::"BXT Purchase Order List");
        // actionContext.AddEntityKey(Rec.FieldNo("Line No."), Rec."Line No.");
        // actionContext.SetResultCode(WebServiceActionResultCode::Created);
        // if BXTPurchaseLine.Get(Rec."Document No.", Rec."Line No.") then begin
        //     BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
        //     BXTPurchaseLine.Description := BCPurchaseLine.Description;
        //     BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
        //     BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
        //     BXTPurchaseLine."Qty. to Receive" := BCPurchaseLine."Qty. to Receive";
        //     BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
        //     BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
        //     BXTPurchaseLine.Modify();
        //     result := 'modify the first line';
        //     BXTPurchaseLine.ClearMarks();
        // end else begin
        //     BXTPurchaseLine."Line No." := Rec."Line No.";
        //     BXTPurchaseLine."Document No." := Rec."Document No.";
        //     BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
        //     BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
        //     BXTPurchaseLine.Description := BCPurchaseLine.Description;
        //     BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
        //     BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
        //     BXTPurchaseLine."Qty. to Receive" := BCPurchaseLine."Qty. to Receive";
        //     BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
        //     BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
        //     BXTPurchaseLine.Insert();
        //     result := 'insertFirstline';
        //     BXTPurchaseLine.ClearMarks();
        // end;



        // BCPurchaseLine.Reset();
        // BXTPurchaseLine.Reset();
        BCPurchaseLine.SetRange("Document Type", DocType::Order);
        BCPurchaseLine.SetRange(Type, lineType::Item);
        isFind := BCPurchaseLine.FindSet();
        if isFind then begin
            repeat
                Received := BCPurchaseLine."Quantity Received";
                Quantity := BCPurchaseLine.Quantity;
                result := 'no change';
                isExist := BCPurchaseLine.Get(DocType::Order, BCPurchaseLine."Document No.", BCPurchaseLine."Line No.");
                isGet := BXTPurchaseLine.Get(BCPurchaseLine."Document No.", BCPurchaseLine."Line No.");
                if isGet then begin
                    result := 'modified';
                    BXTPurchaseLine."Line No." := BCPurchaseLine."Line No.";
                    BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
                    BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
                    BXTPurchaseLine.Description := BCPurchaseLine.Description;
                    BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
                    BXTPurchaseLine."Document No." := BCPurchaseLine."Document No.";
                    BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
                    BXTPurchaseLine."Qty. to Receive" := BCPurchaseLine."Qty. to Receive";
                    BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
                    BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
                    isSuccess := BXTPurchaseLine.Modify();
                    BXTPurchaseLine.ClearMarks();
                    if (Received = Quantity) then begin
                        BXTPurchaseLine."Line No." := BCPurchaseLine."Line No.";
                        BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
                        BXTPurchaseLine.Delete();
                    end;
                end else begin
                    if (Received <> Quantity) then begin
                        BXTPurchaseLine."Line No." := BCPurchaseLine."Line No.";
                        BXTPurchaseLine."Document Type" := BCPurchaseLine.Type;
                        BXTPurchaseLine.Quantity := BCPurchaseLine.Quantity;
                        BXTPurchaseLine.Description := BCPurchaseLine.Description;
                        BXTPurchaseLine."Quantity Received" := BCPurchaseLine."Quantity Received";
                        BXTPurchaseLine."Document No." := BCPurchaseLine."Document No.";
                        BXTPurchaseLine."Buy-from Vendor No." := BCPurchaseLine."Buy-from Vendor No.";
                        BXTPurchaseLine."Qty. to Receive" := BCPurchaseLine."Qty. to Receive";
                        BXTPurchaseLine.Location := BCPurchaseLine."Location Code";
                        BXTPurchaseLine."Item No." := BCPurchaseLine."No.";
                        BXTPurchaseLine.Insert();
                        result := 'insert';
                        BXTPurchaseLine.ClearMarks();
                    end;
                end;
            until BCPurchaseLine.Next() = 0;
            exit(result);
        end;

        BXTPurchaseLine.Reset();
        BXTPurchaseLine.SetRange("Document Type", lineType::Item);
        //BXTPurchaseLine.SetRange("Document No.", 'PO000000046');
        if BXTPurchaseLine.FindSet() then begin
            repeat
                docno := BXTPurchaseLine."Document No.";
                lineno := BXTPurchaseLine."Line No.";
                // docno := 'PO000000046';
                // lineno := 20000;
                isExist := BCPurchaseLine.Get(DocType::Order, docno, lineno);
                if isExist then begin
                    result := 'remain';
                end else begin
                    result := 'Delete';
                    BXTPurchaseLine."Document No." := docno;
                    BXTPurchaseLine."Line No." := lineno;
                    BXTPurchaseLine.Delete();
                    BXTPurchaseLine.ClearMarks();
                end;
            until BXTPurchaseLine.Next() = 0;

        end;
        exit(result);
    end;
}