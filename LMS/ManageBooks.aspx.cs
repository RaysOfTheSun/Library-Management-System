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
            if (Session["IsAdmin"] == null)
            {
                Response.Redirect("~/Home.aspx");
            }

            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                 "$('#books').addClass('active');", true);
        }

        protected void BtnAddAuthor_Click(object sender, EventArgs e)
        {
            ReqValNonExistentAuthor.Validate();
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
            ReqValNonExistingPublisher.Validate();
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
            ReqValPositive.Validate();
            ReqValNonExistentTitle.Validate();
            if (IsValid)
            {
                TbxTitle.Text = TbxTitle.Text.Replace("''''''''", "''''''''''''");
                SourceBooks.Insert();
                TbxTitle.Text = "";
                TbxISBN.Text = "";
                TbxEdition.Text = "1";
                TbxPubYearA.Text = DateTime.Now.Year.ToString();
                TbxQuantity.Text = "1";
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
        protected bool CanDelete(object bookID)
        {
            bool result = true;

            if(BookRentalisRequested(bookID) || BookIsRented(bookID))
            {
                result = false;
            }

            return result;
        }

        protected bool BookRentalisRequested(object bookID)
        {
            bool result = false;
            int bID = Convert.ToInt32(bookID);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(bookID) from " +
                    "RentalRequests WHERE bookID = @id", conn))
                {
                    comm.Parameters.Add("@id", SqlDbType.Int).Value = bID;
                    conn.Open();
                    int rowCount = Convert.ToInt32(comm.ExecuteScalar());

                    if (rowCount >= 1)
                    {
                        result = true;
                    }

                }
            }

            return result;
        }

        protected bool BookIsRented(object bookID)
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

                    if (rowCount >= 1)
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
                string h_title = CleanString(TbxSearchBookGrid.Text);
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{h_title}*\"') OR " +
                    $"CONTAINS(author,'\"{h_title}*\"') OR " +
                    $"CONTAINS(ISBN,'\"{h_title}*\"') OR " +
                    $"CONTAINS(publisherName,'\"{h_title}*\"') OR " +
                    $"CONTAINS(genre,'\"{h_title}*\"') OR " +
                    "bookID IN (SELECT bookID FROM LibraryIndexNamed WHERE " +
                    $"CONTAINS(callNumber, '\"{h_title}*\"'))";
            }

            GrdBooks.DataBind();

        }

        protected void GrdLibraryIndex_DataBound(object sender, EventArgs e)
        {
        }

        protected void Grd_PreRender(object sender, EventArgs e)
        {
            try
            {
                GridView grd = sender as GridView;
                grd.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception)
            {
                // Hide that bug ;)
            }

        }

        protected void TbxSearchBookGrid_TextChanged(object sender, EventArgs e)
        {
            if (TbxSearchBookGrid.Text != string.Empty)
            {
                string h_title = CleanString(TbxSearchBookGrid.Text);
                SourceBooks.SelectCommand = "SELECT * FROM BookDisplay WHERE " +
                    $"CONTAINS(title,'\"{h_title}*\"') OR " +
                    $"CONTAINS(author,'\"{h_title}*\"') OR " +
                    $"CONTAINS(ISBN,'\"{h_title}*\"') OR " +
                    $"CONTAINS(publisherName,'\"{h_title}*\"') OR " +
                    $"CONTAINS(genre,'\"{h_title}*\"') OR " +
                    "bookID IN (SELECT bookID FROM LibraryIndexNamed WHERE " +
                    $"CONTAINS(callNumber, '\"{h_title}*\"'))";
            }

            GrdBooks.DataBind();
        }

        protected void BtnSubtractQuant_Click(object sender, EventArgs e)
        {
            if (TbxQuantity.Text == string.Empty)
            {
                TbxQuantity.Text = "1";
            }
            else
            {
                int quantity = -1;
                if (int.TryParse(TbxQuantity.Text, out quantity))
                {
                    TbxQuantity.Text = quantity <= 1 ? "1" : (quantity - 1).ToString();
                }
            }
        }

        protected void BtnAddQuant_Click(object sender, EventArgs e)
        {
            int quantity = -1;
            if (TbxQuantity.Text == string.Empty)
            {
                TbxQuantity.Text = "1";
            }
            else
            {
                if (int.TryParse(TbxQuantity.Text, out quantity))
                {
                    TbxQuantity.Text = quantity < 0 ? "1" : (quantity += 1).ToString();
                }
            }
        }

        protected void BtnAddEd_Click(object sender, EventArgs e)
        {
            int quantity = -1;
            if (TbxEdition.Text == string.Empty)
            {
                TbxEdition.Text = "1";
            }
            else
            {
                if (int.TryParse(TbxEdition.Text, out quantity))
                {
                    TbxEdition.Text = quantity < 0 ? "1" : (quantity += 1).ToString();
                }
            }
        }

        protected void BtnSubEd_Click(object sender, EventArgs e)
        {
            if (TbxEdition.Text == string.Empty)
            {
                TbxEdition.Text = "1";
            }
            else
            {
                int quantity = -1;
                if (int.TryParse(TbxEdition.Text, out quantity))
                {
                    TbxEdition.Text = quantity <= 1 ? "1" : (quantity - 1).ToString();
                }
            }
        }

        protected void ReqValPositive_ServerValidate(object source, ServerValidateEventArgs args)
        {
            int value = Convert.ToInt32(args.Value);
            if (value < 1)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void BtnSearchPubGrid_Click(object sender, EventArgs e)
        {
            if (TbxSearchPub.Text != string.Empty)
            {
                string h_publisher = CleanString(TbxSearchPub.Text);
                SourcePublishers.SelectCommand = "SELECT * FROM PublisherWithCountryName WHERE " +
                    $"CONTAINS(publisherName,'\"{h_publisher}*\"') OR CONTAINS(countryName,'\"{h_publisher}*\"')";
            }

            GrdPublishers.DataBind();

        }

        protected void BtnSearchAuthor_Click(object sender, EventArgs e)
        {
            if (TbxSearchAuthor.Text != string.Empty)
            {
                string h_author = CleanString(TbxSearchAuthor.Text);
                SourceAuthors.SelectCommand = $"SELECT * FROM BookAuthors WHERE CONTAINS(firstName,'\"{h_author}*\"') OR " +
                    $"CONTAINS(lastName,'\"{h_author}*\"')";
            }

            GrdAuthors.DataBind();

        }

        protected void BtnSearchIdxGrid_Click(object sender, EventArgs e)
        {
            if (TbxSearchIdx.Text != string.Empty)
            {
                string h_title = CleanString(TbxSearchIdx.Text);
                SourceLibrary.SelectCommand = "SELECT * FROM LibraryIndexNamed WHERE title IN " +
                    $"(SELECT title FROM BookDisplay WHERE CONTAINS(title,'\"{h_title}*\"')) OR " +
                    $"fullName IN (SELECT author FROM BookDisplay WHERE CONTAINS(author,'\"{h_title}*\"')) OR " +
                    $"genre IN (SELECT genre FROM BookDisplay WHERE CONTAINS(genre, '\"{h_title}*\"'))";

            }

            GrdLibraryIndex.DataBind();

        }

        protected void BtnAddPubYear_Click(object sender, EventArgs e)
        {
            int quantity = -1;
            if (TbxPubYearA.Text == string.Empty)
            {
                TbxPubYearA.Text = "1";
            }
            else
            {
                if (int.TryParse(TbxPubYearA.Text, out quantity))
                {
                    TbxPubYearA.Text = quantity < 0 ? "1" : (quantity += 1).ToString();
                }
            }
        }

        protected void BtnSubPubYear_Click(object sender, EventArgs e)
        {
            if (TbxPubYearA.Text == string.Empty)
            {
                TbxPubYearA.Text = "1";
            }
            else
            {
                int quantity = -1;
                if (int.TryParse(TbxPubYearA.Text, out quantity))
                {
                    TbxPubYearA.Text = quantity <= 1 ? "1" : (quantity - 1).ToString();
                }
            }
        }

        /// <summary>
        /// Checks if a publisher of a given name exists in the database
        /// </summary>
        /// <param name="publisherName">The name of the publisher</param>
        /// <returns>true if there exists a publihser of the same name</returns>
        private bool IsExistingPublisher(string publisherName)
        {
            int matches = -1;
            publisherName = publisherName.Replace("'", "''");
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(publisherID) AS Matches " +
                    $"FROM PublisherWithCountryName WHERE publisherName = '{publisherName}'", conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            matches = Convert.ToInt32(reader["Matches"]);
                        }
                    }
                }
            }

            if (matches != 0)
            {
                return true;
            }

            return false;
        }

        protected void ReqValNonExistingPublisher_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsExistingPublisher(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /// <summary>
        /// Checks if an author of a given name exists in the database
        /// </summary>
        /// <param name="firstName">The author's first name</param>
        /// <param name="lastName">The author's last name</param>
        /// <returns>True if the author a given first name and last name exists in the database</returns>
        private bool IsExistingAuthor(string firstName, string lastName)
        {
            int matches = -1;
            firstName = firstName.Replace("'", "''");

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(authorID) AS Matches " +
                    $"FROM BookAuthors WHERE firstName = '{firstName}' AND " +
                    $"lastName = '{lastName}'", conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            matches = Convert.ToInt32(reader["Matches"]);
                        }
                    }
                }
            }

            if (matches != 0)
            {
                return true;
            }

            return false;
        }

        protected void ReqValNonExistentAuthor_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsExistingAuthor(args.Value, TbxLastName.Text))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        /// <summary>
        /// Checks if a book of a given name exists in the database
        /// </summary>
        /// <param name="title">The tile of the book</param>
        /// <returns>True if the book of a given title exists in the database</returns>
        private bool IsExistingBook(string title)
        {
            int matches = -1;
            title = title.Replace("'", "''");
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand comm = new SqlCommand("SELECT COUNT(bookID) AS Matches " +
                    $"FROM Books WHERE title = '{title}'", conn))
                {
                    conn.Open();

                    using (SqlDataReader reader = comm.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            matches = Convert.ToInt32(reader["Matches"]);
                        }
                    }
                }
            }

            if (matches != 0)
            {
                return true;
            }

            return false;
        }

        protected void ReqValNonExistentTitle_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (IsExistingBook(args.Value))
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        private string  CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}