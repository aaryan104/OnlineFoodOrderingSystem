<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/DeliveryAgent/AgentMasterPage.Master" AutoEventWireup="true" CodeBehind="AddDeliveryAgent.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.AddDeliveryAgent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-xl font-bold mb-4">Add New Delivery Agent</h2>
    <asp:TextBox ID="txtName" runat="server" Placeholder="Full Name" CssClass="mb-2 block p-2 border rounded"></asp:TextBox>
    <asp:TextBox ID="txtEmail" runat="server" Placeholder="Email" CssClass="mb-2 block p-2 border rounded"></asp:TextBox>
    <asp:TextBox ID="txtPassword" runat="server" Placeholder="Password" CssClass="mb-2 block p-2 border rounded" TextMode="Password"></asp:TextBox>
    <asp:Button ID="btnAdd" runat="server" Text="Add Agent" OnClick="btnAdd_Click" CssClass="bg-green-500 text-white px-4 py-2 rounded" />
</asp:Content>
