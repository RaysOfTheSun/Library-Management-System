using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LMS
{
    public partial class ManageRentals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["IsAdmin"] == null)
            {
                Response.Redirect("~/Home.aspx");
            }
            ClientScript.RegisterStartupScript(GetType(), "setActiveHome",
                "$('#rental').addClass('active');", true);
        }

        protected void BtnDeleteRequest_ServerClick(object sender, EventArgs e)
        {
            SourceRequests.Delete();
            GvwRequests.DataBind();
            ScriptManager.RegisterStartupScript(BtnDeleteRequest, GetType(), "DeleteRequestModal",
                     @"$('#DeleteRequestModal').modal('hide');", true);       
        }

        protected void GvwRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdRentalID.Value = e.CommandArgument.ToString();
        }

        protected void BtnConfirmAcceptRequest__ServerClick(object sender, EventArgs e)
        {
            SourceRequests.Insert();
            GvwRentals.DataBind();
            ScriptManager.RegisterStartupScript(BtnConfirmAcceptRequest_, GetType(), "ConfirmAcceptRequestModal",
                     @"$('#ConfirmAcceptRequestModal').modal('hide');", true);
            ScriptManager.RegisterStartupScript(BtnConfirmAcceptRequest_, GetType(), "UpdateNotifModal",
                @"$('#UpdateNotifModal').modal('toggle');", true);
        }

        protected void GvwRentals_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            HfdRentalID.Value = e.CommandArgument.ToString();
        }

        protected void BtnReturnRental_ServerClick(object sender, EventArgs e)
        {
            SourceRentals.Delete();
            GvwRentals.DataBind();
            ScriptManager.RegisterStartupScript(BtnReturnRental, GetType(), "ReturnRentalModal",
                     @"$('#ReturnRentalModal').modal('hide');", true);
        }

        protected void BtnExtendRental_ServerClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                FvwRentalDetails.UpdateItem(true);
                GvwRentals.DataBind();
                ScriptManager.RegisterStartupScript(BtnExtendRental, GetType(), "ExtendRentalModal",
                    @"$('#ExtendRentalModal').modal('hide');", true);
                ScriptManager.RegisterStartupScript(BtnExtendRental, GetType(), "UpdateNotifModal",
                    @"$('#UpdateNotifModal').modal('toggle');", true);
            }
        }

        protected void ReqNotPastValDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime minDate = DateTime.Now;
            DateTime dt;

            args.IsValid = (DateTime.TryParse(args.Value, out dt)
                && dt >= minDate);
        }

        protected void BtnUpdateSuccess_ServerClick(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(BtnUpdateSuccess, GetType(), "UpdateNotifModal",
                @"$('#UpdateNotifModal').modal('toggle');", true);
        }

        protected void BtnSearchRentalGrid_Click(object sender, EventArgs e)
        {
            if (TbxSearchRenters.Text != string.Empty)
            {
                string h_renter = CleanString(TbxSearchRenters.Text);
                SourceRentals.SelectCommand = "SELECT * FROM RentalDetails WHERE " +
                    $"CONTAINS(accountOwner,'\"{h_renter}*\"') " +
                    $"OR CONTAINS(title,'\"{h_renter}*\"') " +
                    $"OR CONTAINS(fullName,'\"{h_renter}*\"') " +
                    $"OR CONTAINS(ISBN,'\"{h_renter}*\"')";
            }

            GvwRentals.DataBind();
        }

        protected void BtnSearchRequestGrid_Click(object sender, EventArgs e)
        {
            if (TbxSearchRequestGrid.Text != string.Empty)
            {
                string h_requestor = CleanString(TbxSearchRequestGrid.Text);
                SourceRequests.SelectCommand = "SELECT * FROM RentalRequestDetails WHERE " +
                    $"CONTAINS(accountOwner,'\"{h_requestor}*\"') " +
                    $"OR CONTAINS(title,'\"{h_requestor}*\"') " +
                    $"OR CONTAINS(fullName,'\"{h_requestor}*\"') " +
                    $"OR CONTAINS(ISBN,'\"{h_requestor}*\"')"; 
            }

            GvwRequests.DataBind();
        }

        private string CleanString(string input)
        {
            return input.Replace("'", "''");
        }
    }
}