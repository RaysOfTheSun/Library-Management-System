using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Search : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "ALL")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{Request.Params["term"]}*\"') OR " +
                    $"CONTAINS(author,'\"{Request.Params["term"]}*\"') OR " +
                    $"CONTAINS(ISBN,'\"{Request.Params["term"]}*\"') OR " +
                    $"CONTAINS(publisherName,'\"{Request.Params["term"]}*\"') OR " +
                    $"CONTAINS(genre,'\"{Request.Params["term"]}*\"') OR " +
                    "bookID IN (SELECT bookID FROM LibraryIndexNamed WHERE " +
                    $"CONTAINS(callNumber, '\"{Request.Params["term"]}*\"'))";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "TITLE")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{Request.Params["term"]}*\"')";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "GENRE")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(genre,'\"{Request.Params["term"]}*\"')";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "AUTH")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(author,'\"{Request.Params["term"]}*\"')";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "ISBN")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(ISBN,'\"{Request.Params["term"]}*\"')";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "PUB")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(publisherName,'\"{Request.Params["term"]}*\"')";
            }
            else if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "CALLNUM")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE bookID IN " +
                    "(SELECT bookID FROM LibraryIndexNamed WHERE CONTAINS(callNumber, " +
                    $"'\"{Request.Params["term"]}*\"'))";
            }


        }

        protected void ListViewSearchResults_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HfdBookID.Value = e.CommandArgument.ToString();
        }

        protected void BtnConfirmRental_ServerClick(object sender, EventArgs e)
        {
            SourceRentals.Insert();
            ScriptManager.RegisterStartupScript(BtnConfirmRental, GetType(), "rentalNotifModal",
                     @"$('#rentalNotifModal').modal('hide');", true);
        }

        public bool IsLoggedIn()
        {
            if (Session["bID"] == null)
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        protected bool IsAvailable(object bookID)
        {
            bool result = false;
            int bID = Convert.ToInt32(bookID);
            int count = -1;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT bookCount AS count FROM BookStatuses " +
                    "WHERE bookID = @id", conn))
                {
                    comm.Parameters.Add("@id",SqlDbType.Int).Value = bID;
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["count"]);
                        }
                    }
                }
            }

            if (count > 0)
            {
                result = true;
            }

            return result;
        }

        protected bool IsRentable(object bookID)
        {
            return IsLoggedIn() && IsAvailable(bookID);
        }

        protected void BtnSearchLib_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field={DrpField.SelectedValue}&term={TbxSearchTerms.Text}");
        }
    }
}