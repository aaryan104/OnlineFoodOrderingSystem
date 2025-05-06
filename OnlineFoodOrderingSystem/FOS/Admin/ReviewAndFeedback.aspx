<%@ Page Title="" Language="C#" MasterPageFile="~/FOS/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ReviewAndFeedback.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Admin.ReviewAndFeedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-xl font-bold text-gray-800">Customer Reviews</h2>
            <div class="flex items-center space-x-2 hidden">
                <span class="text-gray-600">Sort by:</span>
                <select id="sortReviews"
                    class="border border-gray-300 rounded py-2 px-3 pr-8 text-gray-700 focus:outline-none focus:border-primary">
                    <option value="newest">Newest First</option>
                    <option value="oldest">Oldest First</option>
                    <option value="highest">Highest Rating</option>
                    <option value="lowest">Lowest Rating</option>
                </select>
            </div>
        </div>
        <div class="table-container overflow-x-auto w-full">
            <form runat="server">
                <div class="message text-center flex flex-col items-center">
                    <asp:Label ID="msg" runat="server" ForeColor="red" Text=""></asp:Label>
                </div>
                <asp:GridView ID="gvFeedbacks" runat="server" AutoGenerateColumns="False"
                    CssClass="w-full whitespace-nowrap divide-y divide-gray-200"
                    HeaderStyle-CssClass="bg-gray-50"
                    RowStyle-CssClass="bg-white divide-y divide-gray-200">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                            <ItemTemplate>
                                <div class="text-sm font-semibold text-gray-900">#<%# Eval("OrderId") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Rating" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                            <ItemTemplate>
                                <div class="flex text-yellow-500">
                                    <%# GetStarRating(Convert.ToInt32(Eval("Rating"))) %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Comment" HeaderStyle-CssClass="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                            <ItemTemplate>
                                <div class="text-sm text-gray-900"><%# Eval("Comment") %></div>
                                <div class="text-xs text-gray-500 mt-1">by <%# Eval("FullName") %></div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Date" HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" ItemStyle-CssClass="px-6 py-4 whitespace-nowrap">
                            <ItemTemplate>
                                <div class="text-sm text-gray-500">
                                    <%# Convert.ToDateTime(Eval("FeedbackDate")).ToString("MMMM d, yyyy, hh:mm tt") %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions"
                            HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                            ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <ItemTemplate>
                                <div class="flex justify-end space-x-2">
                                    <asp:LinkButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" CommandArgument='<%# Eval("FeedbackId") %>' 
                                        OnClientClick="return confirm('Are you sure you want to delete this Review Rating?');" CssClass="text-red-500 hover:text-red-700 w-8 h-8 flex items-center justify-center">
                                        <i class="ri-delete-bin-line"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </form>
        </div>
        <div id="noReviews" class="text-center py-8 hidden">
            <div class="w-16 h-16 mx-auto flex items-center justify-center bg-gray-100 rounded-full mb-4">
                <i class="ri-chat-3-line text-gray-400 text-2xl"></i>
            </div>
            <p class="text-gray-500">No reviews available yet</p>
        </div>
    </div>
</asp:Content>
