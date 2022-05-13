page 50138 "BXT BC User Card"
{
    Caption = 'BXT BC User Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BC WHS User";
    ODataKeyFields = UserID;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(UserID; Rec.UserID)
                {
                    ApplicationArea = All;

                }
                field(Username; Rec.Username)
                {
                    ApplicationArea = All;

                }
                field(inactive; Rec.inactive)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    [ServiceEnabled]
    procedure CloneUser(var actionContext: WebServiceActionContext)
    var
        UserMgt: Codeunit BXTBCWHSUserMangement;

    begin
        UserMgt.CloneUser(Rec.UserID);
        actionContext.SetObjectType(ObjectType::Page);
        actionContext.SetObjectId(Page::"BXT BC User Card");
        actionContext.AddEntityKey(Rec.FieldNo(UserID), Rec.UserID);
        actionContext.SetResultCode(WebServiceActionResultCode::Created);
    end;

}