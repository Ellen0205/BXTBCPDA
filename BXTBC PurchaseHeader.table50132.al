table 50132 "BXT Purchase Order Header"
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
        field(2; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(3; "Buy-from Vendor No."; Code[20])
        {
            NotBlank = true;
            Caption = 'Buy-from Vendor No.';
        }

        field(4; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
        }
        field(5; "Location"; Code[20])
        {
            Caption = 'Location';
        }
        field(6; "Status"; Enum "BXT Purchline Status")
        {
            Caption = 'Status';
        }
    }
    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
}
