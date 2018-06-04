using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["curPage"] = "Home.aspx";
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#home').addClass('active');", true);
        }

        protected void BtnSearchLib_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field={DrpField.SelectedValue}&term={TbxSearchTerms.Text}");
        }
    }
}