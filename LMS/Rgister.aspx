<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Rgister.aspx.cs" Inherits="LMS.Rgister" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView ID="FormView1" runat="server" DataSourceID="LibraryDB" DefaultMode="Insert">
        
        <InsertItemTemplate>
            firstName:
            <asp:TextBox ID="firstNameTextBox" runat="server" Text='<%# Bind("firstName") %>' />
            <br />
            middleName:
            <asp:TextBox ID="middleNameTextBox" runat="server" Text='<%# Bind("middleName") %>' />
            <br />
            lastName:
            <asp:TextBox ID="lastNameTextBox" runat="server" Text='<%# Bind("lastName") %>' />
            <br />
            city:
            <asp:TextBox ID="cityTextBox" runat="server" Text='<%# Bind("city") %>' />
            <br />
            street:
            <asp:TextBox ID="streetTextBox" runat="server" Text='<%# Bind("street") %>' />
            <br />
            zipCode:
            <asp:TextBox ID="zipCodeTextBox" runat="server" Text='<%# Bind("zipCode") %>' />
            <br />
            username:
            <asp:TextBox ID="usernameTextBox" runat="server" Text='<%# Bind("username") %>' />
            <br />
            password:
            <asp:TextBox ID="passwordTextBox" runat="server" Text='<%# Bind("password") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
        </InsertItemTemplate>
        
    </asp:FormView>
    <asp:SqlDataSource ID="LibraryDB" runat="server" ConnectionString="<%$ ConnectionStrings:LibraryDBConnectionString %>" SelectCommand="SELECT * FROM [BorrowerAccounts]"></asp:SqlDataSource>
</asp:Content>
