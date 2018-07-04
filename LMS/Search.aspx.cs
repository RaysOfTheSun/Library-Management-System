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
            Session["curPage"] = "Search.aspx";
            string h_term = CleanString(Request.Params["term"]);
            if (Request.Params["term"] != null && Request.Params["field"].Trim().ToUpper() == "ALL")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{h_term}*\"') OR " +
                    $"CONTAINS(author,'\"{h_term}*\"') OR " +
                    $"CONTAINS(ISBN,'\"{h_term}*\"') OR " +
                    $"CONTAINS(publisherName,'\"{h_term}*\"') OR " +
                    $"CONTAINS(genre,'\"{h_term}*\"') OR " +
                    $"CONTAINS(bookSynopsis,'\"{h_term}*\"') OR " +
                    "bookID IN (SELECT bookID FROM LibraryIndexNamed WHERE " +
                    $"CONTAINS(callNumber, '\"{h_term}*\"'))";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "TITLE")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{h_term}*\"')";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "GENRE")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(genre,'\"{h_term}*\"')";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "AUTH")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(author,'\"{h_term}*\"')";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "ISBN")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(ISBN,'\"{h_term}*\"')";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "PUB")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(publisherName,'\"{h_term}*\"')";
            }
            else if (h_term != null && Request.Params["field"].Trim().ToUpper() == "CALLNUM")
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE bookID IN " +
                    "(SELECT bookID FROM LibraryIndexNamed WHERE CONTAINS(callNumber, " +
                    $"'\"{h_term}*\"'))";
            }
        }

        protected void ListViewSearchResults_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HfdBookID.Value = e.CommandArgument.ToString();
            BtnRequestRentV.DataBind();
        }

        protected void BtnConfirmRental_ServerClick(object sender, EventArgs e)
        {
            BtnRequestRentV.DataBind();
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
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = bID;
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

        protected bool IsCurrentlyRented(object bookID, object borrowerID)
        {
            bool result = false;
            int bID = Convert.ToInt32(bookID);
            int count = -1;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(bookID) FROM BookRentals " +
                    "WHERE bookID = @id AND borrowerID = @bID", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = bID;
                    comm.Parameters.Add("@bID", SqlDbType.Int).Value = borrowerID == null ? 0 : borrowerID;
                    conn.Open();
                    count = Convert.ToInt32(comm.ExecuteScalar());
                }
            }

            // not rented
            if (count != 0)
            {
                result = true;
            }

            return result;
        }

        protected bool IsAlreadyRequested(object bookID, object borrowerID)
        {
            bool result = false;
            int bID = Convert.ToInt32(bookID);
            int count = -1;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(bookID) FROM RentalRequests " +
                    "WHERE bookID = @id AND borrowerID = @bID", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = bID;
                    comm.Parameters.Add("@bID", SqlDbType.Int).Value = borrowerID == null ? 0 : borrowerID;
                    conn.Open();
                    count = Convert.ToInt32(comm.ExecuteScalar());
                }
            }

            // not requested
            if (count != 0)
            {
                result = true;
            }

            return result;
        }

        protected bool IsRentable(object bookID)
        {
            object borrowerID = Convert.ToInt32(Session["bID"]);
            return (IsLoggedIn() && IsAvailable(bookID)) &&
                (!IsCurrentlyRented(bookID, borrowerID) && !IsAlreadyRequested(bookID, borrowerID));
        }

        protected string SetAction(object bookID, object borrowerID)
        {
            if (IsAlreadyRequested(bookID, borrowerID))
            {
                return "Rental Requested";
            }
            else if (IsCurrentlyRented(bookID, borrowerID))
            {
                return "Already Rented";
            }
            else if (!IsAvailable(bookID))
            {
                return "Not Available";
            }
            else
            {
                return "Request to Rent";
            }
        }

        protected void BtnSearchLib_Click(object sender, EventArgs e)
        {
            Response.Redirect($"~/Search.aspx?field={DrpField.SelectedValue}&term={TbxSearchTerms.Text}");
        }

        protected void BtnConfirmRequest_ServerClick(object sender, EventArgs e)
        {
            BtnRequestRentV.DataBind();
            SourceRentals.Insert();
            ListViewSearchResults.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmRequest, GetType(), "ConfirmRequestModal",
                @"$('#ConfirmRequestModal').modal('hide');", true);
        }

        private string CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}