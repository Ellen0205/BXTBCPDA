page 50144 "API BXT Purchase Order Header"
{
    PageType = API;
    APIPublisher = 'BCPDA';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    EntityCaption = 'BXTPurchaseOrderHeader';
    EntitySetCaption = 'BXTPurchaseOrderHeaders';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'BXTPurchaseOrderHeader';
    EntitySetName = 'BXTPurchaseOrderHeaders';
    SourceTable = "BXT Purchase Order Header";
    Extensible = false;
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
}