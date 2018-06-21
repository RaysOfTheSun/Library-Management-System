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
            if (Session["IsAdmin"] == null)
            {
                Response.Redirect("~/Home.aspx");
            }
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#users').addClass('active');", true);
        }

        protected void BtnEditAcc_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FvwAccounts.UpdateItem(true);
                GvwAccounts.DataBind();
                ScriptManager.RegisterStartupScript(BtnEditAcc, GetType(), "editAccountModal",
                    @"$('#editAccountModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(BtnEditAcc, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
            }
        }

        protected void GvwDetails_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Session["borrowerID"] = e.CommandArgument.ToString();
        }

        protected void BtnDeleteAccount_ServerClick(object sender, EventArgs e)
        {
            SourceAccountsEdit.Delete();
            GvwAccounts.DataBind();
            ScriptManager.RegisterStartupScript(BtnDeleteAccount, GetType(), "DeleteAccountModal",
                     @"$('#DeleteAccountModal').modal('hide');", true);
        }

        protected void BtnUpdateUserDet_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FvwUserDet.UpdateItem(true);
                GvwDetails.DataBind();
                GvwAccounts.DataBind();
                ScriptManager.RegisterStartupScript(BtnUpdateUserDet, GetType(), "editUserModal",
                    @"$('#editUserModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(BtnUpdateUserDet, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
            }
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
            ScriptManager.RegisterStartupScript(BtnDeleteUser, GetType(), "DeleteUserDetModal",
                     @"$('#DeleteUserDetModal').modal('hide');", true);
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

        protected void BtnUpdateSuccess_ServerClick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(BtnUpdateUserDet, GetType(), "UpdateNotifModal",
                @"$('#UpdateNotifModal').modal('toggle');", true);
        }

        protected void BtnSearchAccountGrid_Click(object sender, EventArgs e)
        {
            if(TbxSearchAccountlGrid.Text != string.Empty)
            {
                string h_account = CleanString(TbxSearchAccountlGrid.Text);
                SourceAccounts.SelectCommand = "SELECT * FROM BorrowerAccounts WHERE " +
                    $"CONTAINS(accountOwner,'\"{h_account}*\"') " +
                    $"OR CONTAINS(userName,'\"{h_account}*\"')";
            }

            GvwAccounts.DataBind();
        }

        protected void BtnSearchUserlGrid_Click(object sender, EventArgs e)
        {
            if(TbxSearchUserlGrid.Text != string.Empty)
            {
                string h_user = CleanString(TbxSearchUserlGrid.Text);
                SourceUsers.SelectCommand = "SELECT borrowerID, firstName, middleName, lastName, " +
                    "countryName, cityName FROM completeBorrowerData WHERE " +
                    $"CONTAINS(firstName,'\"{h_user}*\"') OR CONTAINS(middleName,'\"{h_user}*\"') " +
                    $"OR CONTAINS(lastName,'\"{h_user}*\"') OR CONTAINS(countryName,'\"{h_user}*\"') " +
                    $"OR CONTAINS(cityName,'\"{h_user}*\"')";
            }

            GvwDetails.DataBind();
        }

        private string CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}