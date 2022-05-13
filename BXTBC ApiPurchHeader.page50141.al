page 50141 APIBXTBCPurchHeader
{
    PageType = API;
    APIPublisher = 'BCPDA';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    UsageCategory = Administration;
    SourceTable = "Purchase Header";
    EntityCaption = 'BXTBCPurchHeader';
    EntitySetCaption = 'BXTBCPurchHeaders';
    EntityName = 'BXTBCPurchHeader';
    EntitySetName = 'BXTBCPurchHeaders';
    Extensible = false;
    DelayedInsert = true;
    ODataKeyFields = "Document Type", "No.";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No"; Rec."No.")
                {
                    Caption = 'No';
                    ApplicationArea = All;
                }
                field("DocumentType"; Rec."Document Type")
                {
                    Caption = 'Type';
                    ApplicationArea = All;
                }
                field("BuyfromVendorNo"; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                    ApplicationArea = All;
                }

                field(Location; Rec."Location Code")
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
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
    procedure BXTGetPurchHeader(): Text[200]
    var

        BCPurchHeader: Record "Purchase Header";//sys

        BXTPurchaseLine: Record "BXT Purchase Order Line";//custom

        BXTPurchaseHeader: Record "BXT Purchase Order Header";//custom

        Status: Enum "BXT Purchline Status";
        DocType: Enum "Purchase Document Type";
        LineType: Enum "Purchase Line Type";
        POStatus: Enum "Purchase Document Status";
        isExist: Boolean;
        curDocNo: Code[20];
        DocNo: Code[20];
        curDocType: Enum "Purchase Document Type";
        result: Text[200];
        isGet: Boolean;
    begin
        // BCPurchHeader.SetRange(Status, POStatus::Open);
        // BCPurchHeader.SetRange("Document Type", DocType::Order);
        // if BCPurchHeader.FindSet() then begin
        //     repeat
        //         curDocNo := BCPurchHeader."No.";
        //         curDocType := BCPurchHeader."Document Type";
        //         isExist := BXTPurchaseHeader.Get(curDocType, curDocNo);
        //         if isExist then begin
        //             result := 'modify';
        //             BXTPurchaseHeader.ClearMarks();
        //         end else begin
        //             result := 'insert';
        //             BXTPurchaseHeader.Init();
        //             BXTPurchaseHeader."No." := BCPurchHeader."No.";
        //             BXTPurchaseHeader."Document Type" := BCPurchHeader."Document Type";
        //             BXTPurchaseHeader.Location := BCPurchHeader."Location Code";
        //             BXTPurchaseHeader."Buy-from Vendor No." := BCPurchHeader."Buy-from Vendor No.";
        //             BXTPurchaseHeader.Amount := BCPurchHeader.Amount;
        //             BXTPurchaseHeader.Insert();
        //             BXTPurchaseHeader.ClearMarks();
        //             Commit();
        //         end;
        //     until BCPurchHeader.Next() = 0
        // end;


        // BXTPurchaseHeader.Reset();
        // BXTPurchaseHeader.SetRange("Document Type", DocType::Order);
        // if BXTPurchaseHeader.FindSet() then begin
        //     repeat
        //         DocNo := BXTPurchaseHeader."No.";
        //         isExist := BCPurchHeader.Get(DocType::Order, DocNo);
        //         if isExist then begin
        //             result := 'Remain';
        //             BXTPurchaseHeader.Location := BCPurchHeader."Location Code";
        //             BXTPurchaseHeader.Amount := BCPurchHeader.Amount;
        //             BXTPurchaseHeader.Modify();
        //             if BCPurchHeader.Status = POStatus::Released then begin
        //                 result := 'Delete';
        //                 BXTPurchaseHeader."No." := DocNo;
        //                 BXTPurchaseHeader."Document Type" := DocType::Order;
        //                 BXTPurchaseHeader.Delete();
        //                 BXTPurchaseHeader.ClearMarks();
        //                 Commit();
        //             end;
        //         end else begin
        //             result := 'Delete';
        //             BXTPurchaseHeader."No." := DocNo;
        //             BXTPurchaseHeader."Document Type" := DocType::Order;
        //             BXTPurchaseHeader.Delete();
        //             BXTPurchaseHeader.ClearMarks();
        //             Commit();
        //         end;
        //     until BXTPurchaseHeader.Next() = 0;
        // end;
        // exit(result);
        //==========================================================================================================
        BXTPurchaseLine.SetRange("Document Type", LineType::Item);
        if BXTPurchaseLine.FindSet() then begin
            repeat
                DocNo := BXTPurchaseLine."Document No.";
                isExist := BXTPurchaseHeader.Get(DocType::Order, DocNo);
                BCPurchHeader.Get(DocType::Order, DocNo);
                if isExist then begin
                    result := 'modify';
                    BXTPurchaseHeader."Buy-from Vendor No." := BCPurchHeader."Buy-from Vendor No.";
                    BXTPurchaseHeader.Location := BCPurchHeader."Location Code";
                    BXTPurchaseHeader.Amount := BCPurchHeader.Amount;
                    BXTPurchaseHeader.Modify();
                    BXTPurchaseHeader.ClearMarks();
                end else begin
                    result := 'insert';
                    BXTPurchaseHeader.Init();
                    BXTPurchaseHeader."No." := BCPurchHeader."No.";
                    BXTPurchaseHeader."Document Type" := BCPurchHeader."Document Type";
                    BXTPurchaseHeader.Location := BCPurchHeader."Location Code";
                    BXTPurchaseHeader."Buy-from Vendor No." := BCPurchHeader."Buy-from Vendor No.";
                    BXTPurchaseHeader.Amount := BCPurchHeader.Amount;
                    BXTPurchaseHeader.Insert();
                    BXTPurchaseHeader.ClearMarks();
                    Commit();
                end;
            until BXTPurchaseLine.Next() = 0;
        end;


        BXTPurchaseHeader.Reset();
        BXTPurchaseHeader.SetRange("Document Type", DocType::Order);
        if BXTPurchaseHeader.FindSet() then begin
            repeat
                DocNo := BXTPurchaseHeader."No.";
                isExist := BCPurchHeader.Get(DocType::Order, DocNo);
                if isExist then begin
                    result := 'Remain';
                end else begin
                    result := 'Delete';
                    BXTPurchaseHeader."No." := DocNo;
                    BXTPurchaseHeader."Document Type" := DocType::Order;
                    BXTPurchaseHeader.Delete();
                end;
            until BXTPurchaseHeader.Next() = 0;
        end;
        exit(result);
    end;
}
