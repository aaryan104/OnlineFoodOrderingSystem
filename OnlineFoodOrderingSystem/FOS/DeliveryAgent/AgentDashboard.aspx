<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/DeliveryAgent/AgentMasterPage.Master" AutoEventWireup="true" CodeBehind="AgentDashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.DeliveryAgent.AgentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="text-xl font-bold mb-4">Welcome,
        <asp:Label ID="lblAgentName" runat="server" Text=""></asp:Label></h2>
    <asp:GridView ID="gvOrders" runat="server">
        <Columns>
            <asp:BoundField DataField="OrderId" HeaderText="Order ID" />
            <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" />
            <asp:BoundField DataField="Address" HeaderText="Delivery Address" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:HyperLinkField Text="Update Status" DataNavigateUrlFields="OrderId" DataNavigateUrlFormatString="UpdateOrderStatus.aspx?orderid={0}" />
        </Columns>
    </asp:GridView>
</asp:Content>
