table 50131 "BC WHS User"
{
    Caption = 'BXT BC WHS User';

    fields
    {
        field(1; "UserID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Username; Text[100])
        {
            Caption = 'Username';
        }
        field(3; Password; Text[250])
        {
            Caption = 'Password';
        }
        field(4; inactive; Enum "user status")
        {
            Caption = 'inactive';
        }
    }

    keys
    {
        key(Key1; "UserID")
        {
            Clustered = true;
        }
    }

}
Enum 50134 "user status"
{
    Extensible = true;
    value(0; active)
    {
        Caption = 'active';
    }

    value(1; inactive)
    {
        Caption = 'inactive';
    }
}