using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Transactions;

namespace LMS
{
    public partial class Rgister : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Master.HideFooterHeader();
        }
        
        protected void BtnCreate_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using(SqlConnection conn = new SqlConnection(connectionString))
                {
                    using(TransactionScope tran = new TransactionScope(TransactionScopeOption.RequiresNew))
                    {
                        conn.Open();
                        try
                        {
                            LibraryDB.Insert();
                            tran.Complete();
                        }
                        catch (Exception ex)
                        {
                            //ClientScript.RegisterStartupScript(GetType(), "ERRLOL", $"alert('{ex.Message}');", true);
                        }
                    }
                }

                Response.Redirect(@"~/Login.aspx");

            }
        }
    }
}