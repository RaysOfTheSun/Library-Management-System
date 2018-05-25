using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class ManageRentals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnDeleteRequest_ServerClick(object sender, EventArgs e)
        {
            SourceRequests.Delete();
            GvwRequests.DataBind();
        }

        protected void GvwRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdRentalID.Value = e.CommandArgument.ToString();
        }

        protected void BtnConfirmAcceptRequest__ServerClick(object sender, EventArgs e)
        {
            SourceRequests.Insert();
        }

        protected void GvwRentals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdRentalID.Value = e.CommandArgument.ToString();
        }
    }
}