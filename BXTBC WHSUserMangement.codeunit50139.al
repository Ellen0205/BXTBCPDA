codeunit 50139 "BXTBCWHSUserMangement"
{
    procedure CloneUser(UserID: Integer)
    var
        User: Record "BC WHS User";
        NewUser: Record "BC WHS User";
    begin
        User.Get(UserID);
        NewUser.Init();
        NewUser.TransferFields(User, false);
        NewUser.Username := 'USER BOUND ACTION';
        NewUser.Insert(true);
    end;

    procedure Capitalize(input: Text): Text
    begin
        exit(input.ToUpper);
    end;
}