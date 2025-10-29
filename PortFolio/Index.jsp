<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Purchase & Sales Portfolio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f5e4e8;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: "Poppins", sans-serif;
            }
            .card {
                border-radius: 25px;
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                padding: 2rem 2.5rem;
                background-color: #fff;
                max-width: 450px;
                width: 100%;
            }
            .card-title { 
                color: #61314f; 
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-align: center;
                margin-bottom: 1.5rem;
            }
            h5 {
                color: #9c0361;
                font-weight: bold;
                margin-top: 1.5rem;
                padding-bottom: 5px;
            }
            h6 {
                border-bottom: 2px solid #f3b8d0;
                color: #9c0361;
                font-weight: 700 !important; 
            }

            ul {
                list-style-type: disc; 
                padding-left: 25px;
                margin-top: 10px;
                text-align: left;
            }
            li {
                margin: 8px 0;
            }
            a {
                text-decoration: none;
                color: #d11975;
                font-weight: 500;
                font-size: 15px;
                transition: 0.3s;
            }
            a:hover {
                color: #7a0460;
                text-decoration: underline;
            }
            .icon {
                font-size: 1.2rem;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <div class="card">
            <h5 class="card-title">Purchase & Sales Portfolio</h5>

            <h6> Purchase Section</h6>
            <ul>
                <li><a href="productMaster.jsp">Product Form</a></li>
                <li><a href="SupplierMaster.jsp">Supplier Form</a></li>
                <li><a href="transactionMaster.jsp">Transaction Form</a></li>
                <li><a href="ReportPurchase.jsp">Purchase Report</a></li>
            </ul>

            <h6> Sales Section</h6>
            <ul>
                <li><a href="SalesMaster.jsp">Sales Form</a></li> 
                <li><a href="SalesReport.jsp">Sales Report</a></li>
            </ul>
        </div>
    </body>
</html>
