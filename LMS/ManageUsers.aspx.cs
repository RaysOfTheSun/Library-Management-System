using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnEditAcc_ServerClick(object sender, EventArgs e)
        {
            FvwAccounts.UpdateItem(true);
            GvwAccounts.DataBind();
        }

        protected void GvwDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["borrowerID"] = e.CommandArgument.ToString();
            //hiddenID.Value = e.CommandArgument.ToString();
        }

        protected void BtnDeleteAccount_ServerClick(object sender, EventArgs e)
        {
            SourceAccountsEdit.Delete();
            GvwAccounts.DataBind();
        }
    }
}