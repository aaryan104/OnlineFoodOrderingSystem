<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyOTP.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.VerifyOTP" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f9f9f9;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            margin-bottom: 15px;
            color: #333;
        }

        .otp-input {
            display: flex;
            justify-content: space-between;
            margin: 20px 0;
        }

        .otp-input input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 18px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 0 5px;
        }

        #btnVerify {
            width: 90%;
            padding: 10px;
            background-color: #FEA116;
            color: white;
            border: none;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px 0;
        }

        #btnVerify:hover {
            background-color: #e29013;
        }

        .back-btn {
            color: #FEA116;
            text-decoration: none;
            padding-top: 10px;
        }

        .back-btn:hover {
            color: #e29013;
        }
    </style>
</head>
<body>
    <div class="container">
        <form runat="server">
            <h2>Verify OTP</h2>
            <div class="otp-input">
                <asp:TextBox ID="input1" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 1)" onkeydown="handleInput(event, 1)"></asp:TextBox>
                <asp:TextBox ID="input2" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 2)" onkeydown="handleInput(event, 2)"></asp:TextBox>
                <asp:TextBox ID="input3" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 3)" onkeydown="handleInput(event, 3)"></asp:TextBox>
                <asp:TextBox ID="input4" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 4)" onkeydown="handleInput(event, 4)"></asp:TextBox>
                <asp:TextBox ID="input5" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 5)" onkeydown="handleInput(event, 5)"></asp:TextBox>
                <asp:TextBox ID="input6" runat="server" type="text" maxlength="1" oninput="moveToNext(this, 6)" onkeydown="handleInput(event, 6)"></asp:TextBox>
            </div>
            <asp:Button ID="btnVerify" runat="server" OnClientClick="verifyOTP()" Text="Verify" OnClick="btnVerify_Click1"/>
            <a class="back-btn" href="ForgotPassword.aspx">Change email?</a>
                <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="black" Text=""></asp:Label>
        </form>
    </div>

    <script>
        function moveToNext(input, nextIndex)
        {
            if (input.value.length === 1 && /^\d+$/.test(input.value))
            {
                const nextInput = document.querySelector(`.otp-input input:nth-child(${nextIndex + 1})`);
                if (nextInput)
                {
                    nextInput.focus();
                }
            }
            else
            {
                input.value = '';
            }
        }

        function handleInput(event, currentIndex)
        {
            const input = event.target;
            if (event.key === 'Backspace')
            {
                if (input.value === '')
                {
                    const prevInput = document.querySelector(`.otp-input input:nth-child(${currentIndex - 1})`);
                    if (prevInput)
                    {
                        prevInput.focus();
                    }
                }
            }
            else if (!/^\d+$/.test(event.key))
            {
                event.preventDefault();
            }
        }

        function verifyOTP()
        {
            const otpInputs = document.querySelectorAll('.otp-input input');
            let otp = '';
            otpInputs.forEach(input => {
                otp += input.value;
            });

            if (otp.length === 6)
            {
                // alert('OTP verified successfully!');
                window.location.href = "ResetPassword.aspx";
            } 
            else
            {
                alert('Please enter a valid 6-digit OTP.');
            }
        }
    </script>
</body>
</html>