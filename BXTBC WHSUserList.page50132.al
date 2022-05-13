page 50132 BCWHSUserList
{
    PageType = list;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BC WHS User";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."UserID")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(Username; Rec.Username)
                {
                    Caption = 'Username';
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    Caption = 'Password';
                    ApplicationArea = All;
                }
                field(inactive; Rec.inactive)
                {
                    Caption = 'inactive';
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