﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            InitializeYearList(DrpPubYear);
        }

        protected void BtnAddAuthor_Click(object sender, EventArgs e)
        {
            SourceAuthors.Insert();
            BtnAddAuthorB.Attributes.Add("data-dismiss", "modal");
            TbxFirstname.Text = "";
            TbxLastName.Text = "";
            TbxMiddleName.Text = "";
            UpdateLists();
        }

        protected void BtnAddPublisher_ServerClick(object sender, EventArgs e)
        {
            SourcePublishers.Insert();
            BtnAddPublisher.Attributes.Add("data-dismiss", "modal");
            TbxPublisherName.Text = "";
            DrpCountry.SelectedValue = "-99";
            UpdateLists();
        }

        private void InitializeYearList(DropDownList dl)
        {
            int difference = DateTime.Now.Year - 1969;
            List<ListItem> yearList = new List<ListItem>(difference);
            yearList.Add(new ListItem("Select the year of publication..."));
            for (int i = DateTime.Now.Year; i > 1969; i--)
            {
                yearList.Add(new ListItem(i.ToString()));
            }


           dl.Items.AddRange(yearList.ToArray());
        }

        protected void BtnAddBook_ServerClick(object sender, EventArgs e)
        {
            SourceBooks.Insert();
            BtnAddBook.Attributes.Add("data-dismiss", "modal");
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
            UpdateLists();
        }

        protected void FvBtnUpdateAuth_ServerClick(object sender, EventArgs e)
        {
            FvwAuthors.UpdateItem(true);
            GrdAuthors.DataBind();
            GrdBooks.DataBind();
            UpdateLists();
        }

        protected void BtnEditBook_ServerClick(object sender, EventArgs e)
        {
            FvwBooks.UpdateItem(true);
            GrdBooks.DataBind();
        }

        protected void GrdBooks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            hiddenID.Value = e.CommandArgument.ToString();
            //DropDownList dl = ((DropDownList)FvwBooks.FindControl("DrpPubYearB"));
            //dl.Attributes.Add("SelectedValue", @"'<%# Bind(""publishYear"") %>'");
            //InitializeYearList(dl);
        }

        protected void BtnDeletePub_ServerClick(object sender, EventArgs e)
        {
            SourcePublisherEdit.Delete();
            GrdPublishers.DataBind();
            GrdBooks.DataBind();
            UpdateLists();
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
    }
}