<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Purchase Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { 
                background-color: #f5f7fa; 
            }
            .card-title { 
                color: #f77cb3; font-weight: 700; 
            }
            .form-label { 
                font-weight: 600; 
            }
            .btn-submit, .btn-refresh { 
                border: none; color: white; border-radius: 10px; padding: 10px 20px; transition: 0.3s; 
            }
            .btn-submit {
                background-color: #f77cb3;
            }
            .btn-submit:hover { 
                background-color: #9e4d72; 
            }
            .btn-refresh { 
                background-color: #f77cb3; 
            }
            .btn-refresh:hover { 
                background-color: #9e4d72; 
            }
            .error-message { 
                display: none; color: red; font-size: 0.85em; 
            }
            input.error-input { 
                border: 1px solid red; 
            }
        </style>
    </head>
    <body class="p-4">
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow" style="max-width: 600px; width: 100%;">
                <h4 class="card-title text-center mb-4">Purchase Report</h4>
                <form id="reportForm" novalidate>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="form-label">From Date <span style="color:red">*</span></label>
                            <input type="date" class="form-control form-control-sm" id="fromDate" name="fromDate">
                            <div id="fromDateError" class="error-message">Select a valid from date</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">To Date <span style="color:red">*</span></label>
                            <input type="date" class="form-control form-control-sm" id="toDate" name="toDate">
                            <div id="toDateError" class="error-message">Select a valid to date</div>
                        </div>
                    </div>

                    <div class="text-center mt-3">
                        <button type="button" class="btn-submit me-2" onclick="generateReport()">Generate Report</button>
                        <button type="button" class="btn-refresh" onclick="refreshReport()">Reset</button>
                        <button type="button" class="btn-refresh" onclick="funPrint()">Print</button>
                    </div>
                </form>

                <div class="mt-4" id="reportResults"></div>
            </div>
        </div>
       
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>

                            $("#fromDate").on("input change", function () {
                                if (!$(this).val()) {
                                    $(this).addClass("error-input");
                                    $("#fromDateError").show();
                                } else {
                                    $(this).removeClass("error-input");
                                    $("#fromDateError").hide();
                                }
                            });


                            $("#toDate").on("input change", function () {
                                if (!$(this).val()) {
                                    $(this).addClass("error-input");
                                    $("#toDateError").show();
                                } else {
                                    $(this).removeClass("error-input");
                                    $("#toDateError").hide();
                                }
                            });


                            function funPrint()
                            {
                                  window.open("../../general/master/ReportPurchaseInner.jsp?id=2&fromDate=" + $("#fromDate").val() + "&toDate=" + $("#toDate").val());
                            }

                            function generateReport() {
                                let fromDate = $("#fromDate").val();
                                let toDate = $("#toDate").val();

                                let isValid = true;

                                if (!fromDate) {
                                    $("#fromDate").addClass("error-input").focus();
                                    $("#fromDateError").show();
                                    isValid = false;
                                }
                                if (!toDate) {
                                    $("#toDate").addClass("error-input").focus();
                                    $("#toDateError").show();
                                    isValid = false;
                                }

                                if (!isValid)
                                    return;

                                let productName = $("#productName").val();
                                let supplierName = $("#supplierName").val();

                                let datas = $("#reportForm").serializeArray();
                                datas.push({name: "id", value: 1
                                    
                                $.post("../../general/master/ReportPurchaseInner.jsp", datas, function (data) {
                                    console.log(data)
                                    $("#reportResults").html(data);
                                }, "html");
                            }

                            function refreshReport() {
                                $("#reportForm")[0].reset();
                                $(".error-message").hide();
                                $("input").removeClass("error-input");
                                $("#reportResults").html("");
                            }
        </script>
    </body>
</html>

