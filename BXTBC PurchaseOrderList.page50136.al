page 50136 "BXT Purchase Order List"
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BXT Purchase Order Line";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Document No."; Rec."Document No.")
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
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
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
                field("Quantity Received"; Rec."Quantity Received")
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
                    Caption = 'CurrentReceived';
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