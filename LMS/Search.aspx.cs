using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ListViewSearchResults_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HfdBookID.Value = e.CommandArgument.ToString();
        }

        protected void BtnConfirmRental_ServerClick(object sender, EventArgs e)
        {
            SourceRentals.Insert();
        }
    }
}