<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../../resources/template/PageHeader.jsp"/>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Transaction Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f5f7fa;
            }
            .card-title {
                color: #f77cb3;
                font-weight: 700;
            }
            .form-label {
                font-weight: 600;
            }
            .form-control.error-input {
                border: 1px solid red !important;
            }
            .error-message {
                display: none;
                color: red;
                font-size: 0.85em;
            }
            .btn-submit {
                background-color: #f77cb3;
                border: none;
                color: white;
                border-radius: 10px;
                padding: 10px 20px;
                transition: 0.3s;
            }
            .btn-submit:hover {
                background-color: #9e4d72;
            }
            .btn-refresh{
                background-color: #f77cb3; 
                border: none; 
                color: white; 
                border-radius: 10px; 
                padding: 10px 20px; 
                transition: 0.3s;
            }
        </style>
    </head>
    <body class="p-4">

        <div class="container d-flex justify-content-center">
            <div class="card p-3 shadow" style="max-width: 600px;width: 100%;">
                <h4 class="card-title text-center">Transaction Form</h4>
                <form id="productForm" novalidate>


                    <div class="mb-2 position-relative">
                        <label class="form-label">Product Name</label>
                        <input type="text" class="clsajaxcall form-control form-control-sm " id="productName" name="productName" title="product">
                        <div id="productDiv" class="clsdivs" title="4" style="display:none; position:absolute; background:white; border:1px solid #ccc; border-radius:6px; width:100%; max-height:150px; overflow-y:auto; z-index:999;"></div>
                        <input type="hidden" id="productId" class="clsajaxcall" name="productId">
                        <div id="nameError" class="error-message">Enter a valid product name</div>

                    </div>


                    <div class="mb-2 position-relative">
                        <label class="form-label">Supplier</label>

                        <input type="text" class="form-control form-control-sm clsajaxcall" id="supplier" name="supplier" title="">
                        <div id="supplierDiv" class="clsdivs" title="5" style="display:none; position:absolute; background:white; border:1px solid #ccc; border-radius:6px; width:100%; max-height:150px; overflow-y:auto; z-index:999;"></div>
                        <input type="hidden" id="supplierId" class="clsajaxcall"  name="supplierId">
                        <div id="supplierError" class="error-message">Enter Quantity</div>
                    </div>


                    <div class="row">
                        <div class="col-md-4 mb-2">
                            <label class="form-label">Cost</label>
                            <input type="number" class="form-control form-control-sm numeric-only" id="cost" name="cost" min="0" step="0.01">
                            <div id="costError" class="error-message">Enter a valid cost price</div>
                        </div>
                        <div class="col-md-4 mb-2">
                            <label class="form-label">Quantity</label>
                            <input type="number" class="form-control form-control-sm numeric-only" id="Quantity" name="Quantity" min="0">
                            <div id="qtyError" class="error-message">Enter a valid quantity</div>
                        </div>
                        <div class="col-md-4 mb-2">
                            <label class="form-label">Tax %</label>
                            <input type="number" class="form-control form-control-sm numeric-only" id="tax" name="tax" min="0" step="0.01">
                            <div id="taxError" class="error-message">Enter a valid tax % (0–100)</div>
                        </div>
                    </div>

                    <!-- Tax Amount & Total Amount -->
                    <div class="row">
                        <div class="col-md-6 mb-2">
                            <label class="form-label">Tax Amount</label>
                            <input type="text" class="form-control form-control-sm" id="taxAmt" name="taxAmt" readonly>
                        </div>
                        <div class="col-md-6 mb-2">
                            <label class="form-label">Total Amount</label>
                            <input type="text" class="form-control form-control-sm" id="totalAmt" name="totalAmt" readonly>
                        </div>

                        
                    <!-- Selling Price -->
                    <div class="mb-2">
                        <label class="form-label">Selling Price</label>
                        <input type="number" class="form-control form-control-sm numeric-only" id="sellingPrice" name="sellingPrice" min="0" step="0.01">
                        <div id="sellError" class="error-message">Enter a valid selling price</div>
                    </div>

                    <!-- Submit -->
                    <div class="text-center">
                        <button type="button" onclick="funSaveProduct()" class="btn-submit">Save</button>
                        <button type="button" onclick="refresh()" id="refreshBtn" class="btn-refresh">Refresh</button>
                    </div>
                </form>
            </div>
        </div>



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

            function funSaveProduct() {
                if (!validateForm())
                    return false;

                let datas = $("#productForm").serializeArray();
                datas.push({name: "id", value: 1});

                $.post("../../general/master/transactionInner.jsp", datas, function (data) {
                    console.log("Saved successfully", data);
                    document.getElementById("productForm").reset();
                    document.getElementById("taxAmt").value = "";
                    document.getElementById("totalAmt").value = "";
                }, "text").fail(function (jqXHR) {
                    console.error("Error:", jqXHR.responseText);
                });
            }
            function refresh() {
                document.getElementById("productForm").reset();
                document.getElementById("taxAmt").value = "";
                document.getElementById("totalAmt").value = "";
                $(".error-message").hide();
                $(".form-control").removeClass("error-input");
            }


            // Attach calculation events
            $("#cost, #Quantity, #tax").on("input", calculateAmounts);

            // Clear error when user type
            $("#productName").on("input", function () {
                clearError("productName", "nameError");
            });
            $("#supplier").on("input", function () {
                clearError("supplier", "supplierError");
            });
            $("#cost").on("input", function () {
                clearError("cost", "costError");
            });
            $("#Quantity").on("input", function () {
                clearError("Quantity", "qtyError");
            });
            $("#tax").on("input", function () {
                clearError("tax", "taxError");
            });
            $("#sellingPrice").on("input", function () {
                clearError("sellingPrice", "sellError");
            });


            function calculateAmounts() {
                const cost = parseFloat(document.getElementById("cost").value) || 0;
                const qty = parseFloat(document.getElementById("Quantity").value) || 0;
                const taxPercent = parseFloat(document.getElementById("tax").value) || 0;

                const subtotal = cost * qty;
                const taxAmt = (subtotal * taxPercent) / 100;
                const totalAmt = subtotal + taxAmt;

                document.getElementById("taxAmt").value = taxAmt.toFixed(2);
                document.getElementById("totalAmt").value = totalAmt.toFixed(2);
            }


            function showError(inputId, errorId) {
                document.getElementById(errorId).style.display = "block";
                document.getElementById(inputId).classList.add("error-input");
            }
            function clearError(inputId, errorId) {
                document.getElementById(errorId).style.display = "none";
                document.getElementById(inputId).classList.remove("error-input");
            }


            function validateForm() {
                let isValid = true;
                if ($("#productName").val().trim().length < 2) {
                    showError("productName", "nameError");
                    isValid = false;
                } else {
                    clearError("productName", "nameError");
                }
                if ($("#supplier").val().trim().length < 2) {
                    showError("supplier", "supplierError");
                    isValid = false;
                } else {
                    clearError("supplier", "supplierError");
                }

                let cost = parseFloat($("#cost").val());
                if (isNaN(cost) || cost <= 0) {
                    showError("cost", "costError");
                    isValid = false;
                } else {
                    clearError("cost", "costError");
                }

                let qty = parseInt($("#Quantity").val());
                if (isNaN(qty) || qty <= 0) {
                    showError("Quantity", "qtyError");
                    isValid = false;
                } else {
                    clearError("Quantity", "qtyError");
                }

                let tax = parseFloat($("#tax").val());
                if (isNaN(tax) || tax < 0 || tax > 100) {
                    showError("tax", "taxError");
                    isValid = false;
                } else {
                    clearError("tax", "taxError");
                }

                let sp = parseFloat($("#sellingPrice").val());
                if (isNaN(sp) || sp <= 0) {
                    showError("sellingPrice", "sellError");
                    isValid = false;
                } else {
                    clearError("sellingPrice", "sellError");
                }

                return isValid;
            }
            
            $("#productName, #supplier").on("input", function () {
                validateForm();
            });

            $(".numeric-only").on("keypress", function (e) {
                const charCode = e.which ? e.which : e.keyCode;
                if ((charCode >= 48 && charCode <= 57) || charCode === 46 || charCode === 8 || charCode === 9)
                    return true;
                e.preventDefault();
            });


            function hasContinuousSpaces(str) {
                return /\s{2,}/.test(str);
            }
            function isOnlySpaces(str) {
                return str.trim().length === 0;
            }

            $("#productName, #supplier").on("input blur", function () {
                const id = $(this).attr("id");
                const val = $(this).val();
                const errId = id === "productName" ? "nameError" : "supplierError";
                if (isOnlySpaces(val) || hasContinuousSpaces(val) || val.trim().length < 2)
                {
                    $("#" + errId).text("Enter a valid " + (id === "productName" ? "product" : "supplier") + " name (no extra spaces).").show();
                    $("#" + id).addClass("error-input");
                } else {
                    $("#" + errId).hide();
                    $("#" + id).removeClass("error-input");
                }
            });

            $("#cost, #Quantity, #tax, #sellingPrice").on("input blur", function () {
                const id = $(this).attr("id");
                const val = parseFloat($(this).val());
                if (id === "tax" && (isNaN(val) || val < 0 || val > 100))
                {
                    $("#taxError").text("Tax must be between 0–100.").show();
                    $("#tax").addClass("error-input");
                } else if ((id === "cost" || id === "sellingPrice") && (isNaN(val) || val <= 0)) {
                    $("#" + id + "Error").text("Enter a valid amount.").show();
                    $("#" + id).addClass("error-input");
                } else if (id === "Quantity" && (isNaN(val) || val <= 0)) {
                    $("#qtyError").text("Enter a valid quantity.").show();
                    $("#Quantity").addClass("error-input");
                } else {
                    $("#" + id + "Error").hide();
                    $("#" + id).removeClass("error-input");
                }
            });
            

            function getvaluesfromDB(argId, argFilter, argDiv, argTableName) {
                var ajaxParameter = $("#productForm").serializeArray();
                ajaxParameter.push({name: "ids", value: argId});
                ajaxParameter.push({name: "filter", value: argFilter});

                $.post("../../general/master/transactionInner.jsp", ajaxParameter, function (data) {
                    $(argDiv).html(data);
                    stripeTables(argTableName, 'ui-widget-content', 'ui-widget-content');
                    $(argDiv).show();
                }, "html").error(function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
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
            }    
        </script>

    </body>
</html>
