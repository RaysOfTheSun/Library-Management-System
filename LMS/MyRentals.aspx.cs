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

        /// <summary>
        /// Determines which CSS class is to be applied based on the given return date
        /// </summary>
        /// <param name="returnDate">The date when the rented item is to be returned</param>
        /// <returns>"btn btn-danger" if the return date is less than today's date and btn btn-success otherwise</returns>
        protected string SetCSSClass(object returnDate)
        {
            string css = "btn btn-danger";
            DateTime minDate = DateTime.Now;
            DateTime dt;

            if (DateTime.TryParse(returnDate.ToString(), out dt) && dt > minDate)
            {
                css = "btn btn-success";
            }

            return css;
        }

        /// <summary>
        /// Sets the status indicator for a specific rental based on its return date
        /// </summary>
        /// <param name="returnDate">The date when the rented item is to be returned</param>
        /// <returns>"Overdue" if the return date is less than today's date and "In Progress" otherwise</returns>
        protected string SetText(object returnDate)
        {
            string text = "Overdue";

            DateTime minDate = DateTime.Now;
            DateTime dt;

            if (DateTime.TryParse(returnDate.ToString(), out dt) && dt > minDate)
            {
                text = "In Progress";
            }

            return text;
        }

        private string CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}