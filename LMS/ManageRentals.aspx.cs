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
            ReqNotPastValDate.Validate();
            if (IsValid)
            {
                SourceRentals.Update();
                GvwRentals.DataBind();
                ScriptManager.RegisterStartupScript(BtnExtendRental, GetType(), "ExtendRentalModal",
                         @"$('#ExtendRentalModal').modal('hide');", true); 
            }
        }

        protected void ReqNotPastValDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime minDate = DateTime.Now;
            DateTime dt;

            args.IsValid = (DateTime.TryParse(args.Value, out dt)
                && dt >= minDate);
        }
    }
}