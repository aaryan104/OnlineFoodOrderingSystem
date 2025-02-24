<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Privacy_Policy.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Privacy_Policy" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Privacy Policy - Food Ordering System</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.5.0/fonts/remixicon.css" rel="stylesheet" />
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="../Asset/Library/lib//animate/animate.min.css" rel="stylesheet">
<link href="../Asset/Library/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
<link href="../Asset/Library/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="../Asset/Library/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="../Asset/Library/css/style.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: "#FEA116",
                        secondary: "#FEA116",
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
                },
            },
        };
    </script>
    <style>
        :where([class^="ri-"])::before {
            content: "\f3c2";
        }

        .toc-link.active {
            color: #FEA116;
        }

        @media print {
            .no-print {
                display: none;
            }
        }
    </style>
</head>

<body class="bg-gray-50">
    <div class="container-xxl position-relative p-0">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-0">
            <a href="#" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-3"></i>Kashtabhanjan
                    <img src="../Asset/Library/img/GreenMarco.png" alt="Logo" height="30px" width="30px" style="margin-left: 2%;">
                </h1>

            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="Index.aspx" class="nav-item nav-link active">Home</a>
                    <a href="About.aspx" class="nav-item nav-link">About</a>
                    <a href="Service.aspx" class="nav-item nav-link">Service</a>
                    <a href="Menu.aspx" class="nav-item nav-link">Menu</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu m-0">
                            <!-- <a href="booking.html" class="dropdown-item">Booking</a> -->
                            <a href="Team.aspx" class="dropdown-item">Our Team</a>
                            <!-- <a href="testimonial.html" class="dropdown-item">Testimonial</a> -->
                        </div>
                    </div>
                    <a href="Contact.aspx" class="nav-item nav-link">Contact</a>
                </div>
                <a href="Login.aspx" class="btn btn-primary py-2 px-4">Place Order</a>
            </div>
        </nav>
    </div>
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-24 pb-16">
        <div class="flex flex-col md:flex-row gap-8">
            <aside class="md:w-64 no-print">
                <div class="sticky top-24">
                    <h3 class="text-lg font-semibold mb-4">Table of Contents</h3>
                    <nav class="space-y-2">
                        <a href="#introduction" class="toc-link block text-gray-600 hover:text-primary">Introduction</a>
                        <a href="#data-collection" class="toc-link block text-gray-600 hover:text-primary">Data
                            Collection</a>
                        <a href="#data-usage" class="toc-link block text-gray-600 hover:text-primary">Data Usage</a>
                        <a href="#third-party" class="toc-link block text-gray-600 hover:text-primary">Third-Party
                            Sharing</a>
                        <a href="#user-rights" class="toc-link block text-gray-600 hover:text-primary">User Rights</a>
                        <a href="#cookies" class="toc-link block text-gray-600 hover:text-primary">Cookie Policy</a>
                    </nav>
                    <button onclick="window.print()"
                        class="mt-8 flex items-center gap-2 text-sm text-gray-600 hover:text-primary">
                        <i class="ri-printer-line"></i>
                        Print this page
                    </button>
                </div>
            </aside>
            <div class="flex-1 max-w-3xl">
                <h1 class="text-4xl font-bold mb-8">Privacy Policy</h1>
                <p class="text-gray-600 mb-8">Last updated: February 21, 2025</p>
                <section id="introduction" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">Introduction</h2>
                    <p class="text-gray-700 leading-relaxed">
                        Welcome to our Privacy Policy. This document explains how we
                        collect, use, and protect your personal information when you use
                        our food ordering system. We are committed to ensuring the privacy
                        and security of your data while providing you with a seamless
                        ordering experience.
                    </p>
                </section>
                <section id="data-collection" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">Data Collection</h2>
                    <div class="space-y-4">
                        <div class="bg-white p-6 rounded-lg shadow-sm">
                            <h3 class="text-lg font-medium mb-3">Information We Collect</h3>
                            <ul class="list-disc list-inside text-gray-700 space-y-2">
                                <li>Name and contact information</li>
                                <li>Delivery address</li>
                                <li>Payment information</li>
                                <li>Order history</li>
                                <li>Device information and IP address</li>
                            </ul>
                        </div>
                    </div>
                </section>
                <section id="data-usage" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">Data Usage</h2>
                    <div class="bg-white p-6 rounded-lg shadow-sm">
                        <p class="text-gray-700 mb-4">We use your data to:</p>
                        <div class="grid md:grid-cols-2 gap-4">
                            <div class="p-4 border border-gray-100 rounded">
                                <i class="ri-truck-line text-primary mb-2"></i>
                                <h4 class="font-medium mb-2">Process Orders</h4>
                                <p class="text-sm text-gray-600">
                                    Handle your food orders and delivery
                                </p>
                            </div>
                            <div class="p-4 border border-gray-100 rounded">
                                <i class="ri-customer-service-line text-primary mb-2"></i>
                                <h4 class="font-medium mb-2">Customer Support</h4>
                                <p class="text-sm text-gray-600">
                                    Provide assistance and support
                                </p>
                            </div>
                        </div>
                    </div>
                </section>
                <section id="third-party" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">Third-Party Sharing</h2>
                    <div class="bg-white p-6 rounded-lg shadow-sm overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="border-b">
                                    <th class="text-left py-3">Partner Type</th>
                                    <th class="text-left py-3">Data Shared</th>
                                    <th class="text-left py-3">Purpose</th>
                                </tr>
                            </thead>
                            <tbody class="text-gray-700">
                                <tr class="border-b">
                                    <td class="py-3">Payment Processors</td>
                                    <td class="py-3">Payment Information</td>
                                    <td class="py-3">Process Payments</td>
                                </tr>
                                <tr class="border-b">
                                    <td class="py-3">Delivery Partners</td>
                                    <td class="py-3">Delivery Address</td>
                                    <td class="py-3">Order Fulfillment</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </section>
                <section id="user-rights" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">User Rights</h2>
                    <div class="bg-white p-6 rounded-lg shadow-sm">
                        <div class="space-y-4">
                            <div class="p-4 bg-blue-50 rounded">
                                <h4 class="font-medium mb-2">Access Your Data</h4>
                                <p class="text-sm text-gray-700">
                                    You can request a copy of your personal data
                                </p>
                            </div>
                            <div class="p-4 bg-blue-50 rounded">
                                <h4 class="font-medium mb-2">Data Deletion</h4>
                                <p class="text-sm text-gray-700">
                                    Request deletion of your account and data
                                </p>
                            </div>
                        </div>
                    </div>
                </section>
                <section id="cookies" class="mb-12">
                    <h2 class="text-2xl font-semibold mb-4">Cookie Policy</h2>
                    <div class="bg-white p-6 rounded-lg shadow-sm">
                        <div class="cookie-info">
                            <p class="text-gray-700 mb-4">
                                We use cookies to enhance your browsing experience and analyze
                                site traffic.
                            </p>
                            <button onclick="toggleCookieDetails()"
                                class="text-primary hover:text-blue-700 flex items-center gap-2">
                                <span>Show Details</span>
                                <i class="ri-arrow-down-s-line cookie-arrow"></i>
                            </button>
                            <div id="cookieDetails" class="hidden mt-4 p-4 bg-gray-50 rounded">
                                <h4 class="font-medium mb-2">Cookie Types</h4>
                                <ul class="list-disc list-inside text-gray-700 space-y-2">
                                    <li>Essential cookies for site functionality</li>
                                    <li>Analytics cookies to improve our service</li>
                                    <li>Preference cookies to remember your settings</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </main>
    <button id="backToTop"
        class="fixed bottom-8 right-8 bg-primary text-white p-3 rounded-full shadow-lg hidden hover:bg-blue-600 transition-colors">
        <i class="ri-arrow-up-line"></i>
    </button>
    <script>
        function toggleCookieDetails() {
            const details = document.getElementById("cookieDetails");
            const arrow = document.querySelector(".cookie-arrow");
            details.classList.toggle("hidden");
            arrow.style.transform = details.classList.contains("hidden")
                ? "rotate(0deg)"
                : "rotate(180deg)";
        }
        document.addEventListener("DOMContentLoaded", function () {
            const backToTop = document.getElementById("backToTop");
            const tocLinks = document.querySelectorAll(".toc-link");
            window.addEventListener("scroll", function () {
                if (window.pageYOffset > 300) {
                    backToTop.classList.remove("hidden");
                } else {
                    backToTop.classList.add("hidden");
                }
                const sections = document.querySelectorAll("section");
                let currentSection = "";
                sections.forEach((section) => {
                    const sectionTop = section.offsetTop;
                    if (window.pageYOffset >= sectionTop - 100) {
                        currentSection = section.getAttribute("id");
                    }
                });
                tocLinks.forEach((link) => {
                    link.classList.remove("active");
                    if (link.getAttribute("href").slice(1) === currentSection) {
                        link.classList.add("active");
                    }
                });
            });
            backToTop.addEventListener("click", function () {
                window.scrollTo({
                    top: 0,
                    behavior: "smooth",
                });
            });
            tocLinks.forEach((link) => {
                link.addEventListener("click", function (e) {
                    e.preventDefault();
                    const targetId = this.getAttribute("href").slice(1);
                    const targetSection = document.getElementById(targetId);
                    window.scrollTo({
                        top: targetSection.offsetTop - 80,
                        behavior: "smooth",
                    });
                });
            });
        });
    </script>
</body>

</html>