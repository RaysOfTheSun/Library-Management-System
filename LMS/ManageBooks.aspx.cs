﻿using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace LMS
{
    public partial class Management : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["LibraryDBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnAddAuthor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourceAuthors.Insert();
                TbxFirstname.Text = "";
                TbxLastName.Text = "";

                DrpAuthors.Items.Clear();
                DrpAuthors.DataBind();
                ScriptManager.RegisterStartupScript(BtnAddAuthorB, GetType(), "AddAuthorkModal", @"$('#AddAuthorModal').modal('hide');", true);
            }
        }

        protected void BtnAddPublisher_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourcePublishers.Insert();
                TbxPublisherName.Text = "";

                DrpPublishers.Items.Clear();
                DrpPublishers.DataBind();
                ScriptManager.RegisterStartupScript(BtnAddPublisher, GetType(), "AddPublisherModal", @"$('#AddPublisherModal').modal('hide');", true);
            }
        }

        protected void BtnAddBook_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourceBooks.Insert();
                TbxTitle.Text = "";
                TbxISBN.Text = "";
                TbxEdition.Text = "";
                TbxPubYearA.Text = "";
                TbxQuantity.Text = "";
                GrdBooks.DataBind();
                GrdLibraryIndex.DataBind();
                ScriptManager.RegisterStartupScript(BtnAddBook, GetType(), "AddBookModal",
                    @"$('#AddBookModal').modal('hide');", true);
            }
        }

        protected void GrdPublishers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            hiddenID.Value = e.CommandArgument.ToString();
            Session["keys"] = e.CommandArgument.ToString();
        }

        protected void FvBtnUpdatePub_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FormView1.UpdateItem(true);
                GrdPublishers.DataBind();
                GrdBooks.DataBind();

                DrpPublishers.Items.Clear();
                DrpPublishers.DataBind();
                ScriptManager.RegisterStartupScript(FvBtnUpdatePub, GetType(), "EditAuthorModal",
                    @"$('#EditPublisherModal').modal('hide');", true); 
            }
        }

        protected void FvBtnUpdateAuth_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FvwAuthors.UpdateItem(true);
                GrdAuthors.DataBind();
                GrdBooks.DataBind();
                GrdLibraryIndex.DataBind();

                DrpAuthors.Items.Clear();
                DrpAuthors.DataBind();

                ScriptManager.RegisterStartupScript(FvBtnUpdateAuth, GetType(), "EditAuthorModal",
                    @"$('#EditAuthorModal').modal('hide');", true);
            }
        }

        protected void BtnEditBook_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                Books.UpdateItem(true);
                GrdBooks.DataBind();
                GrdLibraryIndex.DataBind();
                ScriptManager.RegisterStartupScript(BtnEditBook, GetType(), "EditBookModal",
                         @"$('#EditBookModal').modal('hide');", true);
            }
        }

        protected void GrdBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            hiddenID.Value = e.CommandArgument.ToString();
            Session["keys"] = e.CommandArgument.ToString();
        }

        protected void BtnDeletePub_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourcePublisherEdit.Delete();
                GrdPublishers.DataBind();
                GrdBooks.DataBind();

                DrpPublishers.Items.Clear();
                DrpPublishers.DataBind();
                ScriptManager.RegisterStartupScript(BtnDeletePub, GetType(), "DeletePublisher",
                         @"$('#DeletePublisher').modal('hide');", true); 
            }

        }

        protected void BtnDeleteAuthor_ServerClick(object sender, EventArgs e)
        {
            SourceAuthorEdit.Delete();
            GrdAuthors.DataBind();
            GrdBooks.DataBind();
            GrdLibraryIndex.DataBind();

            DrpAuthors.Items.Clear();
            DrpAuthors.DataBind();
            ScriptManager.RegisterStartupScript(BtnDeleteAuthor, GetType(), "DeleteAuthorModal",
                     @"$('#DeleteAuthorModal').modal('hide');", true);
        }

        protected void BtnDeleteBook_ServerClick(object sender, EventArgs e)
        {
            SourceBookEdit.Delete();
            GrdBooks.DataBind();
            ScriptManager.RegisterStartupScript(BtnDeleteBook, GetType(), "DeleteBookModal",
                     @"$('#DeleteBookModal').modal('hide');", true);
        }

        protected void BtnResetBookFields_ServerClick(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "disableTitleErr", @"$(#ReqValTitle).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableISBNErr", @"$(#ReqVaISBN).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableQuantErr", @"$(#ReqValQuant).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableEditionErr", @"$(#ReqValEdition).hide();", true);
        }

        protected void BtnResetAuthorFields_ServerClick(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "disableFirstNameErr", @"$(#ReqValFirstName).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableLastNameErr", @"$(#ReqValLastName).hide();", true);
        }

        protected void BtnResetPublisherFields_ServerClick(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(GetType(), "disableLastNameTbx", @"$(#ReqValPub).hide();", true);
        }

        protected bool IsOwnerOfRentedBook(object authorID)
        {
            bool result = false;
            int aID = Convert.ToInt32(authorID);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(authorID) from " +
                    "RentedBooksWithAuthorID WHERE authorID = @id", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = aID;
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

        protected bool IsPublisherOfRentedBook(object publisherID)
        {
            bool result = false;
            int pID = Convert.ToInt32(publisherID);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(publisherID) from " +
                    "RentedBooksWithAuthorID WHERE publisherID = @id", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = pID;
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

        protected bool IsRented(object bookID)
        {
            bool result = false;
            int bID = Convert.ToInt32(bookID);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(bookID) from " +
                    "BookRentals WHERE bookID = @id", conn))
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

        protected void FvBtnUpdateCallNum_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FvwLibIndex.UpdateItem(true);
                GrdLibraryIndex.DataBind();
                ScriptManager.RegisterStartupScript(BtnDeleteBook, GetType(), "EditLibIndexModal",
                         @"$('#EditLibIndexModal').modal('hide');", true);
            }
        }
    }
}