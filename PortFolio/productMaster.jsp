<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:include page="../../resources/template/PageHeader.jsp"/>--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Product Name Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { 
                background-color: #f5f7fa; 
            }
            .card-title { 
                color: #4CAF50; 
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
                margin-top: 4px; }
            .btn-submit, .btn-view, .btn-refresh {
                background-color: #4CAF50; 
                border: none; color: white;
                border-radius: 10px;
                padding: 10px 20px; 
                transition: 0.3s;
            }
            .btn-submit:hover, 
            .btn-view:hover, 
            .btn-refresh:hover { 
                background-color: #388E3C; 
            }
        </style>
    </head>
    <body class="p-4">

        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow" style="max-width: 400px; width: 100%;">
                <h4 class="card-title text-center mb-3">Product Form</h4>

                <form id="productForm" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Enter Product Name</label>
                        <input type="text" class="form-control form-control-sm" id="productName" name="productName">
                        <input type="hidden" id="productId" name="productId" value="0">
                        <div id="productNameError" class="error-message">Product name must be at least 2 characters</div>
                    </div>

                    <div class="text-center mt-3">
                        <button type="button" id="saveBtn" onclick="funSaveProduct()" class="btn-submit">Save Product</button>
                        <button type="button" id="viewBtn" onclick="funViewProduct()" class="btn-view">View</button>
                        <button type="button" id="refreshBtn" class="btn-refresh">Refresh</button>
                    </div>
                </form>
                <div class="table-container mt-4" id="productTableDiv" style="display:none;">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <h5 class="text-success mb-3 text-center">Product List</h5>
                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle table-striped text-center" id="productTable">

                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                            function showError(inputId, errorId) {
                                $("#" + errorId).show();
                                $("#" + inputId).addClass("error-input");
                            }

                            function clearError(inputId, errorId) {
                                $("#" + errorId).hide();
                                $("#" + inputId).removeClass("error-input");
                            }

                            function validateForm() {
                                const pname = $("#productName").val().trim();
                                if (pname.length < 2) {
                                    showError("productName", "productNameError");
                                    return false;
                                } else {
                                    clearError("productName", "productNameError");
                                    return true;
                                }
                            }
                            function funSaveProduct() {
                                if (!validateForm())
                                    return;
                                var datas = [];
                                datas.push({name: "productName", "value": $("#productName").val().trim()});
                                datas.push({name: "productId", "value": $("#productId").val()});

                                if ($("#productId").val() == 0) {
                                    datas.push({name: "id", "value": 1});
                                } else {
                                    datas.push({name: "id", "value": 3});
                                }


                                $.post("../../general/master/productInner.jsp", datas, function (resp) {
                                    alert(resp.trim());
                                    $("#productForm")[0].reset();
                                    $("#productForm").removeData("edit-id");
                                    $("#saveBtn").text("Save Product");
                                    funViewProduct();
                                }).fail(function () {
                                    alert("Error saving product");
                                });
                            }
                            function funViewProduct() {
                                $("#productTableDiv").show();
                                $("#productTable tbody").html("<tr><td colspan='2'>Loading...</td></tr>");

                                $.post("../../general/master/productInner.jsp", {action: "view"}, function (data) {
                                    $("#productTable tbody").html(data);
                                }).fail(function (jqXHR) {
                                    alert("Error fetching product: " + (jqXHR.statusText || "server error"));
                                });
                            }

                            function editProduct(productName, productId) {
                                $("#productName").val(productName);
                                $("#productId").val(productId);
                                $("#saveBtn").text("Update Product");
                            }

                            function deleteProduct(btn) {
                                var id = $(btn).closest("tr").data("id");

                                if (!confirm("Are you sure you want to delete this product?"))
                                    return;

                                $.post("../../general/master/productInner.jsp", {action: "delete", productId: id}, function (resp) {
                                    alert(resp.trim());
                                    funViewProduct();
                                }).fail(function () {
                                    alert("Error deleting product");
                                });
                            }

                            $(document).ready(function () {
                                $("#productForm")[0].reset();
                                $("#productForm input").on("keydown", function (e) {
                                    if (e.key === "Enter") {
                                        e.preventDefault();
                                        return false;
                                    }
                                });


                                $("#productForm").on("input", "input", function () {
                                    const val = $(this).val().trim();
                                    if (val.length < 2) {
                                        showError("productName", "productNameError");
                                    } else {
                                        clearError("productName", "productNameError");
                                    }
                                });


                                $("#refreshBtn").click(function () {
                                    $("#productForm")[0].reset();
                                    clearError("productName", "productNameError");
                                    $("#productTableDiv").hide();
                                    $("#productTable tbody").empty();
                                });
                            });
            </script>
    </body>
</html>

