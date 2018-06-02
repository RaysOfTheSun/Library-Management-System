using System;
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
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#books').addClass('active');", true);
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
                ScriptManager.RegisterStartupScript(BtnAddAuthorB, GetType(), "AddAuthorkModal",
                    @"$('#AddAuthorModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(BtnAddAuthorB, GetType(), "AdditionNotifModal",
                    @"$('#AdditionNotifModal').modal('toggle');", true);

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
                ScriptManager.RegisterStartupScript(BtnAddPublisher, GetType(), "AddPublisherModal",
                    @"$('#AddPublisherModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(BtnAddPublisher, GetType(), "AdditionNotifModal",
                    @"$('#AdditionNotifModal').modal('toggle');", true);
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
                ScriptManager.RegisterStartupScript(BtnAddBook, GetType(), "AdditionNotifModal",
                    @"$('#AdditionNotifModal').modal('toggle');", true);
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
                GrdLibraryIndex.DataBind();

                DrpPublishers.Items.Clear();
                DrpPublishers.DataBind();
                ScriptManager.RegisterStartupScript(FvBtnUpdatePub, GetType(), "EditAuthorModal",
                    @"$('#EditPublisherModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(FvBtnUpdatePub, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
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
                ScriptManager.RegisterStartupScript(FvBtnUpdateAuth, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
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
                ScriptManager.RegisterStartupScript(BtnEditBook, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
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
                GrdLibraryIndex.DataBind();

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
            GrdLibraryIndex.DataBind();
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

        /// <summary>
        /// Checks whether a book associated with a given author is currently being rented
        /// </summary>
        /// <param name="authorID">The ID that identifies the author in the database</param>
        /// <returns>Boolean value of True if any book associated to the given author is currently
        /// being rented</returns>
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

        /// <summary>
        /// Checks whether any book associated to a publisher is currently being rented
        /// </summary>
        /// <param name="publisherID">The ID that identifies the publisher in the database</param>
        /// <returns>Boolean value of True if any book that was published by the publuisher is 
        /// currently being rented</returns>
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

        /// <summary>
        /// Checks whether a given book is currently being rented
        /// </summary>
        /// <param name="bookID">The ID that identifies the book in the database</param>
        /// <returns>Boolean value of True if the book is currently being rented</returns>
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
                ScriptManager.RegisterStartupScript(FvBtnUpdateCallNum, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
            }
        }

        protected void BtnUpdateSuccess_ServerClick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(BtnUpdateSuccess, GetType(), "UpdateNotifModal",
                @"$('#UpdateNotifModal').modal('hide');", true);
        }

        protected void BtnAdditionSuccess_ServerClick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(BtnAdditionSuccess, GetType(), "AdditionNotifModal",
                @"$('#AdditionNotifModal').modal('hide');", true);
        }

        protected void BtnSearchBookGrid_Click(object sender, EventArgs e)
        {
            if (TbxSearchBookGrid.Text != string.Empty)
            {
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{TbxSearchBookGrid.Text}*\"') OR " +
                    $"CONTAINS(author,'\"{TbxSearchBookGrid.Text}*\"') OR " +
                    $"CONTAINS(ISBN,'\"{TbxSearchBookGrid.Text}*\"') OR " +
                    $"CONTAINS(publisherName,'\"{TbxSearchBookGrid.Text}*\"') OR " +
                    $"CONTAINS(genre,'\"{TbxSearchBookGrid.Text}*\"') OR " +
                    "bookID IN (SELECT bookID FROM LibraryIndexNamed WHERE " +
                    $"CONTAINS(callNumber, '\"{TbxSearchBookGrid.Text}*\"'))";
                GrdBooks.DataBind();
            }
            else
            {
                GrdBooks.DataBind();
            }
        }
    }
}