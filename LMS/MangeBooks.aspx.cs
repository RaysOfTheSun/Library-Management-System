using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnAddAuthor_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourceAuthors.Insert();
                BtnAddAuthorB.Attributes.Add("data-dismiss", "modal");
                TbxFirstname.Text = "";
                TbxLastName.Text = "";
                TbxMiddleName.Text = "";

                DrpAuthors.Items.Clear();
                DrpAuthors.DataBind();
                ScriptManager.RegisterStartupScript(BtnAddAuthorB, GetType(), "AddAuthorkModal", @"$('#AddAuthorModal').modal('hide');", true);
            }
        }

        protected void BtnAddPublisher_ServerClick(object sender, EventArgs e)
        {
            SourcePublishers.Insert();
            TbxPublisherName.Text = "";

            DrpPublishers.Items.Clear();
            DrpPublishers.DataBind();
            ScriptManager.RegisterStartupScript(BtnAddPublisher, GetType(), "AddPublisherModal", @"$('#AddPublisherModal').modal('hide');", true);
        }

        protected void BtnAddBook_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                SourceBooks.Insert();
                ScriptManager.RegisterStartupScript(BtnAddBook, GetType(), "AddBookModal", @"$('#AddBookModal').modal('hide');", true);
            }
        }

        protected void GrdPublishers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            hiddenID.Value = e.CommandArgument.ToString();
            Session["keys"] = e.CommandArgument.ToString();
        }

        protected void FvBtnUpdatePub_ServerClick(object sender, EventArgs e)
        {
            FormView1.UpdateItem(true);
            GrdPublishers.DataBind();
            GrdBooks.DataBind();

            DrpPublishers.Items.Clear();
            DrpPublishers.DataBind();
        }

        protected void FvBtnUpdateAuth_ServerClick(object sender, EventArgs e)
        {
            FvwAuthors.UpdateItem(true);
            GrdAuthors.DataBind();
            GrdBooks.DataBind();

            DrpAuthors.Items.Clear();
            DrpAuthors.DataBind();
        }

        protected void BtnEditBook_ServerClick(object sender, EventArgs e)
        {
            Books.UpdateItem(true);
            GrdBooks.DataBind();
        }

        protected void GrdBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            hiddenID.Value = e.CommandArgument.ToString();
            Session["keys"] = e.CommandArgument.ToString();
        }

        protected void BtnDeletePub_ServerClick(object sender, EventArgs e)
        {
            SourcePublisherEdit.Delete();
            GrdPublishers.DataBind();
            GrdBooks.DataBind();

            DrpPublishers.Items.Clear();
            DrpPublishers.DataBind();
        }

        private void UpdateLists()
        {
            DrpCountry.Items.Clear();
            DrpPublishers.Items.Clear();
            DrpAuthors.Items.Clear();

            DrpAuthors.DataBind();
            DrpPublishers.DataBind();
            DrpCountry.DataBind();
        }

        protected void BtnDeleteAuthor_ServerClick(object sender, EventArgs e)
        {
            SourceAuthorEdit.Delete();
            GrdAuthors.DataBind();
            GrdBooks.DataBind();

            DrpAuthors.Items.Clear();
            DrpAuthors.DataBind();
        }

        protected void BtnDeleteBook_ServerClick(object sender, EventArgs e)
        {
            SourceBookEdit.Delete();
            GrdBooks.DataBind();
        }

        protected void BtnResetBookFields_ServerClick(object sender, EventArgs e)
        {
            //ReqValTitle.IsValid = true;
            ClientScript.RegisterStartupScript(GetType(), "disableTitle", @"$(#ReqValTitle).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableISBN", @"$(#ReqVaISBN).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableQuant", @"$(#ReqValQuant).hide();", true);
            ClientScript.RegisterStartupScript(GetType(), "disableEdition", @"$(#ReqValEdition).hide();", true);
        }
    }
}