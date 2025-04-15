<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/DeliveryAgent/AgentMasterPage.Master" AutoEventWireup="true" CodeBehind="UpdateOrderStatus.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.UpdateOrderStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-xl font-bold mb-4">Update Order Status</h2>
    <asp:Label ID="lblOrder" runat="server" CssClass="block mb-2"></asp:Label>
    <asp:DropDownList ID="ddlStatus" runat="server">
        <asp:ListItem>-- Select --</asp:ListItem>
        <asp:ListItem>Picked Up</asp:ListItem>
        <asp:ListItem>On the way</asp:ListItem>
        <asp:ListItem>Delivered</asp:ListItem>
    </asp:DropDownList>
    <asp:Button ID="btnUpdate" runat="server" Text="Update Status" OnClick="btnUpdate_Click" CssClass="bg-blue-500 text-white px-4 py-2 rounded" />
</asp:Content>
