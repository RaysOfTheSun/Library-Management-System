using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace LMS
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnEditAcc_ServerClick(object sender, EventArgs e)
        {
            FvwAccounts.UpdateItem(true);
            GvwAccounts.DataBind();
        }

        protected void GvwDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["borrowerID"] = e.CommandArgument.ToString();
            //hiddenID.Value = e.CommandArgument.ToString();
        }

        protected void BtnDeleteAccount_ServerClick(object sender, EventArgs e)
        {
            SourceAccountsEdit.Delete();
            GvwAccounts.DataBind();
        }

        protected void BtnUpdateUserDet_ServerClick(object sender, EventArgs e)
        {
            FvwUserDet.UpdateItem(true);
            GvwDetails.DataBind();
        }

        protected void GvwDetails_RowCommand1(object sender, GridViewCommandEventArgs e)
        {
            Session["borrowerID"] = e.CommandArgument.ToString();
            hideenID.Value = e.CommandArgument.ToString();
        }

        protected void BtnDeleteUser_ServerClick(object sender, EventArgs e)
        {
            SourceUsersEdit.Delete();
            GvwDetails.DataBind();
            GvwAccounts.DataBind();
        }

        protected bool IsRenting(object borrowerID)
        {
            bool result = false;
            int bID = Convert.ToInt32(borrowerID);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(borrowerID) from " +
                    "BookRentals WHERE borrowerID = @id", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = bID;
                    conn.Open();
                    int rowCount = Convert.ToInt32(comm.ExecuteScalar());

                    if (rowCount <= 0)
                    {
                        result = true;
                    }

                }
            }

            return result;
        }
    }
}