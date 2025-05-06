<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Review_Feedback.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Review_Feedback" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Review & Feedback</title>
    <script src="https://cdn.tailwindcss.com/3.4.16"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.6.0/remixicon.min.css" />
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FEA116",
                        secondary: "#333333",
                    },
                    borderRadius: {
                        none: "0px",
                        sm: "4px",
                        DEFAULT: "8px",
                        md: "12px",
                        lg: "16px",
                        xl: "20px",
                        "2xl": "24px",
                        "3xl": "32px",
                        full: "9999px",
                        button: "8px",
                    },
                    fontFamily: {
                        poppins: ["Poppins", "sans-serif"],
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-gray-100">
    <%--<asp:Label ID="lblOrderId" runat="server" Text=""></asp:Label>--%>
    <div class="min-h-screen flex flex-col">
        <main class="flex-grow w-full py-8">
            <div class="w-full px-4">
                <div class="text-center mb-8">
                    <h1 class="text-3xl font-bold text-gray-800">
                        Order Review & Feedback
                    </h1>
                    <p class="text-gray-600 mt-2">
                        Share your experience with us and help us improve
                    </p>
                </div>
                <form runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server" />
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="max-w-2xl mx-auto px-4">
                                <div class="bg-white rounded-lg shadow-md p-6 mb-10">
                                    <div class="mb-6    ">
                                        <label class="block text-gray-700 font-medium mb-2">
                                            Order ID</label>
                                        <div class="flex items-center">
                                            <asp:TextBox ID="txtOrderId" runat="server" CssClass="w-full px-4 py-3 border border-gray-300 rounded text-gray-700 bg-gray-50" ReadOnly="true"></asp:TextBox>
                                            <div class="ml-2 text-gray-500 text-sm">Auto-populated</div>
                                        </div>
                                    </div>
                                    <div class="mb-6">
                                        <label class="block text-gray-700 font-medium mb-2">Your Rating <span class="text-red-500">*</span></label>
                                        <div class="flex space-x-1 text-2xl text-yellow-400 cursor-pointer" id="starRating">
                                            <i class="ri-star-line" data-value="1"></i>
                                            <i class="ri-star-line" data-value="2"></i>
                                            <i class="ri-star-line" data-value="3"></i>
                                            <i class="ri-star-line" data-value="4"></i>
                                            <i class="ri-star-line" data-value="5"></i>
                                        </div>
                                        <asp:HiddenField ID="hfRating" runat="server" />
                                        <asp:Label ID="lblRatingError" runat="server" CssClass="text-red-500 text-sm mt-1" Visible="false">Please select a rating</asp:Label>
                                    </div>

                                    <div class="mb-6 relative">
                                        <label for="comment" class="block text-gray-700 font-medium mb-2">Your Comment <span class="text-red-500">*</span></label>
                                        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5" CssClass="w-full px-4 py-3 border border-gray-300 rounded resize-none" 
                                            MaxLength="500" placeholder="Share your experience about the food and service..."></asp:TextBox>
                                        <div class="char-counter">
                                            <asp:Label ID="lblCharCount" runat="server" Text="0"></asp:Label>/500
                                        </div>
                                        <asp:Label ID="lblCommentError" runat="server" CssClass="text-red-500 text-sm mt-1" Visible="false">Please enter your comment</asp:Label>
                                    </div>
                                    <div class="message text-center flex flex-col items-center">
                                        <asp:Label ID="lblMessage" runat="server" text=""></asp:Label>
                                    </div>
                                    <div class="flex justify-end">
                                        <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" CssClass="bg-primary text-white py-3 px-6 rounded-button hover:bg-opacity-90 transition whitespace-nowrap" 
                                            OnClick="btnSubmitReview_Click" />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </div>
        </main>
    </div>

    <script>
        const stars = document.querySelectorAll('#starRating i');
        const hfRating = document.getElementById('<%= hfRating.ClientID %>');

        stars.forEach(star => {
            star.addEventListener('click', function () {
                const rating = this.getAttribute('data-value');
                hfRating.value = rating;

                stars.forEach(s => {
                    s.classList.remove('ri-star-fill');
                    s.classList.add('ri-star-line');
                });

                for (let i = 0; i < rating; i++) {
                    stars[i].classList.remove('ri-star-line');
                    stars[i].classList.add('ri-star-fill');
                }
            });
        });
    </script>

</body>
</html>
