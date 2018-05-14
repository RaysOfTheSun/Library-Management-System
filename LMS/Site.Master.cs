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

        }

        public void HideFooterHeader()
        {
            header.Visible = false;
            navbar.Visible = false;
            footer_primary.Visible = false;
        }
    }
}