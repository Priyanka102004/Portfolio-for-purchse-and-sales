<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:include page="../../resources/template/PageHeader.jsp"/>--%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Supplier Name Form</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body { 
                background-color: #f5f7fa; }
            .card-title { 
                color:#de4763; 
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
                margin-top: 4px; 
            }
            .btn-submit { 
                background-color:#de4763 ; 
                border: none; 
                color: white; 
                border-radius: 10px; 
                padding: 10px 20px; 
                transition: 0.3s; 
            }
            .btn-submit:hover { 
                background-color:#b8485c; 
            }
        </style>
    </head>
    <body class="p-4">

        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow" style="max-width: 400px; width: 100%; length:50%">
                <h4 class="card-title text-center mb-3">Supplier Form</h4>

                <form id="supplierForm" novalidate>
                    <div class="mb-3">
                        <label class="form-label">Enter Supplier Name</label>
                        <input type="text" class="form-control form-control-sm" id="supplierName" name="supplierName">
                        <div id="supplierNameError" class="error-message">Product name must be at least 2 characters</div>
                    </div>

                    <div class="text-center mt-3">
                        <button type="button" id="saveBtn" onclick="funSaveSupplier()" class="btn-submit">Save</button>
                    </div>
                </form>
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
                                const pname = $("#supplierName").val().trim();
                                if (pname.length < 2) {
                                    showError("supplierName", "supplierNameError");
                                    return false;
                                } else {
                                    clearError("supplierName", "supplierNameError");
                                    return true;
                                }
                            }

                            function funSaveSupplier() {
                                if (!validateForm())
                                    return;

                                const formData = $("#supplierForm").serializeArray();
                                formData.push({name: "id", value: 2});

                                $.post("../../general/master/productInner.jsp", formData, function (data) {
                                    $("#supplierForm")[0].reset();
                                    alert(data);
                                }).fail(function (jqXHR) {
                                    alert("Error saving: " + (jqXHR.statusText || "server error"));
                                });
                            }

                            $(document).ready(function () {
                                $("#supplierForm")[0].reset();

                                // prevent Enter key submit
                                $("#supplierForm input").on("keydown", function (e)
                                {
                                    if (e.key === "Enter") {
                                        e.preventDefault();
                                        return false;
                                    }
                                });

                                // live validation
                                $("#supplierForm").on("input", "input", function () {
                                    const val = $(this).val().trim();
                                    if (val.length >= 2)
                                        clearError("supplierName", "supplierNameError");
                                });
                            });
        </script>
    </body>
</html>
  