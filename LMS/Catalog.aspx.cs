using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace LMS
{
    public partial class Catalog : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["curPage"] = "Catalog.aspx";
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#catalog').addClass('active');", true);
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
                    comm.Parameters.Add("@bID", SqlDbType.Int).Value = borrowerID == null? 0: borrowerID;
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

        protected void LvwBooks_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HfdBookID.Value = e.CommandArgument.ToString();
            BtnRequestRentV.DataBind();

        }

        protected void BtnConfirmRental_ServerClick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(BtnConfirmRental, GetType(), "rentalNotifModal",
                @"$('#rentalNotifModal').modal('hide');", true);
        }

        protected void BtnConfirmRequest_ServerClick(object sender, EventArgs e)
        {
            SourceRentals.Insert();
            LvwBooks.DataBind();
            BtnRequestRentV.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmRequest, GetType(), "ConfirmRequestModal",
                @"$('#ConfirmRequestModal').modal('hide');", true);
        }
    }
}