pageextension 50134 "Page Menu Extension" extends "Business Manager Role Center"
{
    actions
    {
        addlast(embedding)
        {
            action("BXT BC WHS User")
            {

                ApplicationArea = Basic, Suite;
                Caption = 'BXT BC WHS User';
                RunObject = Page "BCWHSUserList";
                ToolTip = 'Add a new User.';
            }
            action("BXT BC Purchase Order List")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'BXT BC Purchase Order List';
                RunObject = Page "BXT Purchase Order List";
                ToolTip = 'Add a new Purchase Order Item.';
            }

        }
    }
}
