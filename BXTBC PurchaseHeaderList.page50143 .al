page 50143 "BXT Purchase Order Header"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BXT Purchase Order Header";

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
                field("No."; Rec."No.")
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

                field(Location; Rec.Location)
                {
                    Caption = 'Location';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
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

    var
        myInt: Integer;
}