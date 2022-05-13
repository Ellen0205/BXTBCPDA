page 50133 APIBXTBCWHSUser
{
    PageType = API;
    APIPublisher = 'BCPDA';
    APIGroup = 'demo';
    APIVersion = 'v2.0';
    EntityCaption = 'BCWHSUser';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'BCWHSUser';
    EntitySetName = 'BCWHSUsers';
    SourceTable = "BC WHS User";
    Extensible = false;
    //Permissions = TableData "BC WHS User" = rimd;
    //ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("UserID"; Rec."UserID")
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