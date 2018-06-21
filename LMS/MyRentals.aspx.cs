using System;
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
            if (TbxSearchRentalGrid.Text != string.Empty)
            {
                string h_borrower = CleanString(TbxSearchRentalGrid.Text);
                int borrowerID = Convert.ToInt32(Session["bID"]);
                SourceRentals.SelectCommand = "SELECT * FROM RentalDetails WHERE (" +
                    $"CONTAINS(title,'\"{h_borrower}*\"') " +
                    $"OR CONTAINS(fullName,'\"{h_borrower}*\"') " +
                    $"OR CONTAINS(ISBN,'\"{h_borrower}*\"')) " +
                    $"AND borrowerID = {borrowerID}";
            }

            GvwRentals.DataBind();
        }

        private string CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}