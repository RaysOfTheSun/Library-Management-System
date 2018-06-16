using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BtnLogout.DataBind();
            BtnMyRentals.DataBind();
        }

        public void HideFooterHeader()
        {
            header.Visible = false;
            navbar.Visible = false;
            footer_primary.Visible = false;
        }

        protected bool IsLoggedIn()
        {
            if(Session["bID"] == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        protected void BtnMyRentals_Click(object sender, EventArgs e)
        {
            if (IsLoggedIn())
            {
                Response.Redirect("~/MyRentals.aspx");
            }
            else
            {
                Response.Redirect("~/Home.aspx");
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
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