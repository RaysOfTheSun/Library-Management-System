using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnAddAuthor_Click(object sender, EventArgs e)
        {
            SourceAuthors.Insert();
            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "AddAuthorModal", "$('#AddAuthorModal').modal('hide');", true);
        }
    }
}