page 50139 "API BXT BC User Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BC WHS User";

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

    [ServiceEnabled]
    procedure Capitalize(input: Text): Text
    begin
        exit(input.ToUpper);
    end;
}