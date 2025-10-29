<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../../resources/template/PageHeader.jsp"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <title>Sales Form</title>

        <style>
            body {
                background-color: #fae6e8;
            }
            .card-title {
                color: #ed2644;
                font-weight: 700;
            }
            .form-label {
                font-weight: 600;
            }
            .is-invalid {
                border: 1px solid red !important;
            }
            .is-valid {
                border: 1px solid #28a745 !important;
            }
            .invalid-feedback {
                display: block;
                color: red;
                font-size: 0.85em;
            }
            .btn-submit, .btn-refresh {
                background-color: #f5384e;
                border: none;
                color: white;
                border-radius: 10px;
                padding: 10px 20px;
                transition: 0.3s;
            }
            .btn-submit:hover, .btn-refresh:hover {
                background-color: #f58788;
            }
        </style>
    </head>

    <body class="p-4">
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow" style="max-width: 500px; width: 100%;">
                <h3 class="card-title text-center mb-4">Sales Form</h3>

                <form id="salesForm" novalidate>

                    <div class="mb-2 position-relative">
                        <label class="form-label">Product Name</label>
                        <input type="text" class="form-control form-control-sm clsajaxcall" id="productName" name="productName">
                        <div id="productDiv" class="clsdivs" title="4" style="display:none; position:absolute; background:white; border:1px solid #ccc; border-radius:6px; width:100%; max-height:150px; overflow-y:auto; z-index:999;"></div>
                        <input type="hidden" id="productId" class="clsajaxcall" name="productId">
                        <div class="invalid-feedback" id="productNameError"></div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Quantity</label>
                        <input type="text" class="form-control form-control-sm" id="quantity" name="quantity">
                        <div class="invalid-feedback" id="quantityError"></div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Sales Price</label>
                        <input type="text" class="form-control form-control-sm" id="salesPrice" name="salesPrice">
                        <div class="invalid-feedback" id="salesPriceError"></div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Tax (%)</label>
                        <input type="text" class="form-control form-control-sm" id="tax" name="tax">
                        <div class="invalid-feedback" id="taxError"></div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Discount (%)</label>
                        <input type="text" class="form-control form-control-sm" id="discount" name="discount">
                        <div class="invalid-feedback" id="discountError"></div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Total Amount</label>
                        <input type="text" class="form-control form-control-sm" id="totalAmount" name="totalAmount" readonly>
                        <div class="invalid-feedback" id="totalAmountError"></div>
                    </div>

                    <div class="text-center mt-3">
                        <button type="button" id="saveBtn" class="btn-submit" onclick="funsaveForm()">Save</button>
                        <button type="button" id="refreshBtn" class="btn-refresh" onclick="refreshForm()">Refresh</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
                            var frmTitle = "Transaction";
                            var tblList = ['', '', '', 'tbl1'];
                            $(function () {
                                $(':input.clsajaxcall[type="text"]').keyup(function (event) {
                                    var ldivobj = $(this).nextAll('.clsdivs:first');
                                    var ldiv = "#" + ldivobj.attr("id");
                                    var txtobj = $(this).attr("id")[0];

                                    if (!callKeyNavigation(event, tblList[ldivobj.attr("title")], txtobj)) {
                                        return;
                                    }
                                    getvaluesfromDB(ldivobj.attr("title"), $(this).val(), ldiv, tblList[ldivobj.attr("title")]);
                                });

                            })
                            const form = document.getElementById("salesForm");
                            const btnSubmit = document.getElementById("saveBtn");
                            const btnRefresh = document.getElementById("refreshBtn");

                            const fields = {
                                productName: document.getElementById("productName"),
                                quantity: document.getElementById("quantity"),
                                salesPrice: document.getElementById("salesPrice"),
                                tax: document.getElementById("tax"),
                                discount: document.getElementById("discount"),
                                totalAmount: document.getElementById("totalAmount")
                            };

                            const errors = {
                                productName: document.getElementById("productNameError"),
                                quantity: document.getElementById("quantityError"),
                                salesPrice: document.getElementById("salesPriceError"),
                                tax: document.getElementById("taxError"),
                                discount: document.getElementById("discountError"),
                                totalAmount: document.getElementById("totalAmountError")
                            };


                            ["quantity", "salesPrice", "tax", "discount"].forEach(id => {
                                fields[id].addEventListener("input", (e) => {
                                    e.target.value = e.target.value.replace(/[^0-9.]/g, "");
                                });
                            });


                            function calculateTotal() {
                                let q = parseFloat(fields.quantity.value) || 0;
                                let price = parseFloat(fields.salesPrice.value) || 0;
                                let tax = parseFloat(fields.tax.value) || 0;
                                let discount = parseFloat(fields.discount.value) || 0;

                                let total = (q * price) + ((q * price) * tax / 100) - ((q * price) * discount / 100);
                                fields.totalAmount.value = total.toFixed(2);
                            }

                            ["quantity", "salesPrice", "tax", "discount"].forEach(id => {
                                fields[id].addEventListener("input", calculateTotal);
                            });

                            function validateField(fieldName) {
                                const field = fields[fieldName];
                                const error = errors[fieldName];
                                const value = field.value.trim();
                                let message = "";

                                if (fieldName === "productName") {
                                    if (!value)
                                        message = "Product name is required.";
                                    else if (!/^[A-Za-z0-9\s\-]+$/.test(value))
                                        message = "Only letters, numbers, and spaces allowed.";
                                }

                                if (fieldName === "quantity") {
                                    if (!value)
                                        message = "Quantity is required.";
                                    else if (isNaN(value) || Number(value) <= 0)
                                        message = "Enter a valid quantity greater than 0.";
                                }

                                if (fieldName === "salesPrice") {
                                    if (!value)
                                        message = "Sales price is required.";
                                    else if (isNaN(value) || Number(value) <= 0)
                                        message = "Enter a valid sales price greater than 0.";
                                }

                                if (fieldName === "tax") {
                                    if (!value)
                                        message = "Tax percentage is required.";
                                    else if (isNaN(value) || Number(value) < 0 || Number(value) > 100)
                                        message = "Tax must be between 0 and 100.";
                                }

                                if (fieldName === "discount") {
                                    if (!value)
                                        message = "Discount is required.";
                                    else if (isNaN(value) || Number(value) < 0 || Number(value) > 100)
                                        message = "Discount must be between 0 and 100.";
                                }

                                error.textContent = message;
                                field.classList.toggle("is-invalid", message !== "");
                                field.classList.toggle("is-valid", message === "");

                                return message === "";
                            }

                            function validateAllFields() {
                                let valid = true;
                                Object.keys(fields).forEach(name => {
                                    if (!validateField(name))
                                        valid = false;
                                });
                                return valid;
                            }

                            function funsaveForm() {
                                if (!validateAllFields()) {
                                    alert("Please correct the highlighted fields.");
                                    return;
                                }

                                let datas = $("#salesForm").serializeArray();
                                datas.push({name: "id", value: 1});

                                $.post("../../general/master/SalesInner.jsp", datas, function (data) {
                                    console.log(data)
                                    console.log(data.code)
                                     alert(data.msg)
                                    form.reset();
                                    Object.values(fields).forEach(f => f.classList.remove("is-valid", "is-invalid"));
                                    Object.values(errors).forEach(e => e.textContent = "");
                                }, "json").fail(function (jqXHR) {
                                    console.error("Error:", jqXHR.responseText);
                                    alert("Error saving form: " + jqXHR.responseText);
                                });
                            }

                            function refreshForm() {
                                form.reset();
                                Object.values(fields).forEach(f => f.classList.remove("is-valid", "is-invalid"));
                                Object.values(errors).forEach(e => e.textContent = "");
                            }

                            Object.keys(fields).forEach(name => {
                                fields[name].addEventListener("input", () => validateField(name));
                                fields[name].addEventListener("blur", () => validateField(name));
                            });
                            function getvaluesfromDB(argId, argFilter, argDiv, argTableName) {
                                var ajaxParameter = $("#salesForm").serializeArray();
                                ajaxParameter.push({name: "ids", value: argId});
                                ajaxParameter.push({name: "filter", value: argFilter});

                                $.post("../../general/master/SalesInner.jsp", ajaxParameter)
                                        .done(function (data) {
                                            $(argDiv).html(data);
                                            stripeTables(argTableName, 'ui-widget-content', 'ui-widget-content');
                                            $(argDiv).show();
                                        })
                                        .fail(function (jqXHR, textStatus, errorThrown) {
                                            console.error("AJAX Error:", textStatus, errorThrown);
                                            alert("Error: " + jqXHR.responseText);
                                        });
                            }


                            function funCloseDivs(argObject) {
                                var divObject = $(argObject).parents('.clsdivs:first');
                                var textObject = divObject.prevAll('.clsajaxcall:first');
                                var hiddenObject = divObject.next('.clsajaxcall');
                                textObject.val("");
                                hiddenObject.val("");
                                divObject.html("");
                                divObject.hide();
                                document.getElementById(divObject.attr("id")).style.display = 'none';
                            }

                            function selectAppSubmData(argObject) {
                                var divObject = $(argObject).parents('.clsdivs:first');
                                var textObject = divObject.prevAll('.clsajaxcall:first');
                                var hiddenObject = divObject.next('.clsajaxcall');

                                textObject.val($(argObject).attr("title"));
                                hiddenObject.val($(argObject).attr("id"));

                                divObject.html("");
                                divObject.hide();
                                document.getElementById(divObject.attr("id")).style.display = 'none';
                                textObject.trigger("blur")

                                $('#productName').removeClass('is-invalid').addClass('is-valid');
                                $('#productNameError').text('');
                            }
        </script>
    </body>
</html>
