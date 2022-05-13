table 50135 "BXT Purchase Order Line"
{
    Caption = 'BXT Purchase Order Line';
    DrillDownPageID = "Purchase Lines";
    LookupPageID = "Purchase Lines";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Document Type"; Enum "Purchase Line Type")
        {
            Caption = 'Document Type';
        }
        field(3; "Buy-from Vendor No."; Code[20])
        {
            NotBlank = true;
            Caption = 'Buy-from Vendor No.';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

        }
        field(7; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
        }

        field(8; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';

        }
        field(9; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(11; "Location"; Code[20])
        {
            Caption = 'Location';
        }
        field(12; "UserID"; Integer)
        {
            Caption = 'UserId';
        }
        field(13; "Description"; Text[100])
        {
            Caption = 'Description';
        }
        field(14; "Status"; Enum "BXT Purchline Status")
        {
            Caption = 'Status';
        }
        field(15; "CurrRece"; Integer)
        {
            Caption = 'CurrRece';

        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
enum 50138 "BXT Purchline Status"
{
    Extensible = true;
    value(0; "notChange")
    {
        Caption = 'notChange';
    }
    value(1; "modified")
    {
        Caption = 'modified';
    }
}