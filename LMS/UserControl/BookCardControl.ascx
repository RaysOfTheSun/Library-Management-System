<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookCardControl.ascx.cs" Inherits="LMS.UserControl.ProductCardControl" %>

<div class="card m-1" >
    <a href='ProductDetails.aspx?sku=<%# Eval("sku") %>' class="card-link" style="text-decoration: none; color: inherit">
        <img src='<%# RenderImage(Eval("img_url"))%>' alt="Product Image" class="card-img-top" />
        <div class="card-body">
            <h6 class="card-text">
                <asp:Label ID="nameLabel" runat="server" Text='<%# Eval("name") %>' />
            </h6>
            <asp:Label ID="priceLabel" runat="server" Text='<%# Eval("price", "{0:c}") %>' CssClass="card-text" />
            <br />
            <br />
            <div class="d-flex flex-row">
                <asp:Button ID="BtnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary p-2" CommandArgument='<%#Eval("sku") + "," + Eval("price") %>' Enabled='<%# IsAvailable(Eval("qty")) %>' />
            </div>
        </div>
    </a>
</div>
