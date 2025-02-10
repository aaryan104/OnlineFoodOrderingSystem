<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineFoodOrderingSystem.FOS.Customer.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body {
            background-color: #E3E7E8;
            font-family: system-ui;
        }

        .container {
            width: 1000px;
            margin: auto;
            transition: 0.5s;
        }

        header {
            display: grid;
            grid-template-columns: 1fr 50px;
            margin-top: 10px;
        }

        header .shopping {
            position: relative;
            text-align: right;
        }

        header .shopping img {
            width: 40px;
            margin-top: 20px;
        }

        header .shopping span {
            background: red;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
            position: absolute;
            top: -5px;
            left: 80%;
            padding: 3px 10px;
            margin-top: 15px;
        }

        .list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            column-gap: 20px;
            row-gap: 20px;
            margin-top: 50px;
        }

        .list .item {
            text-align: center;
            background-color: #DCE0E1;
            padding: 20px;
            box-shadow: 0 50px 50px #757676;
            letter-spacing: 1px;
        }

        .list .item img {
            width: 50%;
            height: 60%;
            object-fit: cover;
        }

        .list .item .title {
            font-weight: 600;
        }

        .list .item .price {
            margin: 10px;
        }

        .list .item button {
            background-color: #1C1F25;
            color: #fff;
            width: 100%;
            padding: 10px;
        }

        .card {
            position: fixed;
            top: 0;
            left: 100%;
            width: 500px;
            background-color: #453E3B;
            height: 100vh;
            transition: 0.5s;
        }

        .active .card {
            left: calc(100% - 500px);
        }

        .active .container {
            transform: translateX(-200px);
        }

        .card h1 {
            color: #E8BC0E;
            font-weight: 100;
            margin: 0;
            padding: 0 20px;
            height: 80px;
            display: flex;
            align-items: center;
        }

        .card .checkOut {
            position: absolute;
            bottom: 0;
            width: 100%;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
        }

        .card .checkOut div {
            background-color: #E8BC0E;
            width: 100%;
            height: 70px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            cursor: pointer;
        }

        .card .checkOut div:nth-child(2) {
            background-color: #1C1F25;
            color: #fff;
        }

        .listCard li {
            display: grid;
            grid-template-columns: 100px repeat(3, 1fr);
            color: #fff;
            row-gap: 10px;
        }

        .listCard li div {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .listCard li img {
            width: 90%;
        }

        .listCard li button {
            background-color: #fff5;
            border: none;
        }

        .listCard .count {
            margin: 0 10px;
        }

        @media (max-width: 1024px) {
            .container {
                width: 90%;
            }

            .list {
                grid-template-columns: repeat(2, 1fr);
            }

            .card {
                width: 400px;
            }

            .active .card {
                left: calc(100% - 400px);
            }

            .active .container {
                transform: translateX(-150px);
            }
        }

        @media (max-width: 768px) {
            .container {
                width: 95%;
            }

            header {
                grid-template-columns: 1fr 40px;
            }

            .list {
                grid-template-columns: repeat(1, 1fr);
            }

            .list .item img {
                width: 80%;
                height: auto;
            }

            .card {
                width: 100%;
            }

            .active .card {
                left: 0;
            }

            .active .container {
                transform: translateX(0);
            }
        }

        @media (max-width: 480px) {
            .list .item {
                padding: 15px;
            }

            .list .item img {
                /*width: 100%;*/
                height: auto;
            }

            .listCard li {
                grid-template-columns: 80px repeat(3, 1fr);
            }

            .card h1 {
                font-size: 20px;
            }

            .card .checkOut {
                grid-template-columns: 1fr;
            }

            .card .checkOut div {
                height: 50px;
                font-size: 14px;
            }
        }

    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>FOS</h1>
            <div class="shopping">
                <img src="../../Asset/Library/img/AddToCart.png">
                <span class="quantity">0</span>
            </div>
        </header>

        <div class="list">
        </div>
    </div>
    <div class="card">
        <h1>Card</h1>
        <ul class="listCard">
        </ul>
        <div class="checkOut">
            <div class="total">0</div>
            <div class="closeShopping">Close</div>
        </div>
    </div>

    <script>
        let openShopping = document.querySelector('.shopping');
        let closeShopping = document.querySelector('.closeShopping');
        let list = document.querySelector('.list');
        let listCard = document.querySelector('.listCard');
        let body = document.querySelector('body');
        let total = document.querySelector('.total');
        let quantity = document.querySelector('.quantity');

        openShopping.addEventListener('click', () => {
            body.classList.add('active');
        })
        closeShopping.addEventListener('click', () => {
            body.classList.remove('active');
        })

        let products = [
            {
                id: 1,
                name: 'Pizza',
                image: 'menu09.jpg',
                price: 200
            },
            {
                id: 2,
                name: 'Burger',
                image: 'menu11.jpg',
                price: 50
            },
            {
                id: 3,
                name: 'Sandwich',
                image: 'menu12.jpg',
                price: 70
            },
            {
                id: 4,
                name: 'Masala Dosa',
                image: 'menu08.jpg',
                price: 80
            },
            {
                id: 5,
                name: 'Waffles',
                image: 'menu13.jpg',
                price: 95
            },
            {
                id: 6,
                name: 'Maggi',
                image: 'menu15.jpg',
                price: 80
            },
            {
                id: 7,
                name: 'Momos',
                image: 'menu16.jpg',
                price: 40
            }
        ];
        let listCards = [];
        function initApp() {
            products.forEach((value, key) => {
                let newDiv = document.createElement('div');
                newDiv.classList.add('item');
                newDiv.innerHTML = `
            <img src="../../Asset/Library/img/${value.image}" alt="no image priview">
            <div class="title">${value.name}</div>
            <div class="price">MRP ₹${value.price.toLocaleString()}</div>
            <button onclick="addToCard(${key})">Add To Card</button>`;
                list.appendChild(newDiv);
            })
        }
        initApp();
        function addToCard(key) {
            if (listCards[key] == null) {
                // copy product form list to list card
                listCards[key] = JSON.parse(JSON.stringify(products[key]));
                listCards[key].quantity = 1;
            }
            reloadCard();
        }
        function reloadCard() {
            listCard.innerHTML = '';
            let count = 0;
            let totalPrice = 0;
            listCards.forEach((value, key) => {
                totalPrice = totalPrice + value.price;
                count = count + value.quantity;
                if (value != null) {
                    let newDiv = document.createElement('li');
                    newDiv.innerHTML = `
                <div><img src="../../Asset/Library/img/${value.image}"></div>
                <div>${value.name}</div>
                <div>${value.price.toLocaleString()}</div>
                <div>
                    <button onclick="changeQuantity(${key}, ${value.quantity - 1})">-</button>
                    <div class="count">${value.quantity}</div>
                    <button onclick="changeQuantity(${key}, ${value.quantity + 1})">+</button>
                </div>`;
                    listCard.appendChild(newDiv);
                }
            })
            total.innerText = totalPrice.toLocaleString();
            quantity.innerText = count;
        }
        function changeQuantity(key, quantity) {
            if (quantity == 0) {
                delete listCards[key];
            } else {
                listCards[key].quantity = quantity;
                listCards[key].price = quantity * products[key].price;
            }
            reloadCard();
        }
    </script>
</body>
</html>
