using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace LMS
{
    public partial class Login : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Master.HideFooterHeader();
            if (Session["bID"] != null)
            {
                Response.Redirect(@"~/Home.aspx");
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            if (tbx_username.Text.ToLower() == "admin" && tbx_password.Text == "admin")
            {
                // This was not a requirement of this project. 
                // hard coding is the way to go ;)
                Session["IsAdmin"] = true;
                Response.Redirect(@"~/ManageBooks.aspx");
            }
            else if (IsValidAccount(tbx_username.Text, tbx_password.Text))
            {
                Session["bID"] = GetID(tbx_username.Text, tbx_password.Text);
                if(Session["curPage"] != null)
                {
                    Response.Redirect($"~/{(string)Session["curPage"]}");
                }
                else
                {
                    Response.Redirect(@"~/Home.aspx");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(GetType(), "invalidCredentials",
                    "alert('Invalid username or password!');", true);
                tbx_username.Text = string.Empty;
                tbx_password.Text = string.Empty;
            }
        }

        /// <summary>
        /// Checks if the provided credentials matches any records in the database based on the number of
        /// rows returned.
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        protected bool IsValidAccount(string userName, string password)
        {
            bool result = false;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(*) FROM UserAccounts " +
                    "WHERE userName = @name AND [password] = @pass", conn))
                {
                    comm.Parameters.AddWithValue("@name", tbx_username.Text);
                    comm.Parameters.AddWithValue("@pass", tbx_password.Text);
                    conn.Open();
                    int rowCount = Convert.ToInt32(comm.ExecuteScalar());

                    if (rowCount != 0)
                    {
                        result = true;
                    }
                }
            }

            return result;
        }

        protected int GetID(string userName, string password)
        {
            int borrowerID = -1;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT [owner] FROM UserAccounts " +
                    "WHERE userName = @name AND [password] = @pass", conn))
                {
                    comm.Parameters.AddWithValue("@name", tbx_username.Text);
                    comm.Parameters.AddWithValue("@pass", tbx_password.Text);
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            borrowerID = Convert.ToInt32(reader["owner"]);
                        }
                    }
                }
            }

            return borrowerID;
        }
    }
}