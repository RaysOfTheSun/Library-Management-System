using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.HideFooterHeader();
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            Response.Redirect(@"~/Default.aspx");
        }
    }
}