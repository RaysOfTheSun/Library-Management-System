﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class MyRentals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["bID"] == null)
            {
                Session["curPage"] = "MyRentals.aspx";
                Response.Redirect(@"~/Home.aspx");
            }
        }

        protected void BtnSearchRentalGrid_Click(object sender, EventArgs e)
        {

        }
    }
}