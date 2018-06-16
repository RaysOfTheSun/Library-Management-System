using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Administrator : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Session.Remove("IsAdmin");
            Response.Redirect("~/Home.aspx");
        }

        protected void btn_bottomFind_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field=all&term={TbxBottomFind.Text}");
        }

        protected void BtnTopFind_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field=all&term={TbxTopFind.Text}");
        }
    }
}