codeunit 50140 BXTPurchaseManagement
{
    procedure ModifyQtyToReceive(DocumentNo: Code[20]; LineNo: Integer; QtytoReceive: Decimal)
    var
        OrderLine: Record "BXT Purchase Order Line";
        BCOrderLine: Record "Purchase Line";
        result: Text[20];
        DocType: Enum "Purchase Document Type";
        isSuccess: Boolean;
        LINE: Integer;
        Status: Enum "BXT Purchline Status";
    begin
        OrderLine.SetRange("Document No.", DocumentNo);
        OrderLine.SetRange("Line No.", LineNo);

        // BCOrderLine.SetRange("Document Type", DocType::Order);
        // BCOrderLine.SetRange("Document No.", DocumentNo);
        // BCOrderLine.SetRange("Line No.", LineNo);
        //BCOrderLine.SetRange();
        if OrderLine.FindSet() then begin
            OrderLine."Qty. to Receive" := QtyToReceive;
            OrderLine.Status := Status::modified;
            OrderLine.Modify();
            IF BCOrderLine.get(DocType::Order, DocumentNo, LineNo) then;
            BCOrderLine."Qty. to Receive" := QtyToReceive;
            BCOrderLine.Validate("Qty. to Receive", QtyToReceive);
        end;
        //isSuccess := BCOrderLine.Get(DocType::Order, DocumentNo, LineNo);
    end;

}