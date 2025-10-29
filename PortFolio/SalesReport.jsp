<%-- 
    Document   : SalesReport
    Created on : Oct 22, 2025, 4:11:45 PM
    Author     : Priyanka
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SALES REPORT</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
             
    <style>
           body { 
                background-color: #f6f2fa; 
            }
            .card-title { 
                color: #c275e6; font-weight: 700; 
            }
            .form-label { 
                font-weight: 600; 
            }
            .btn-submit, .btn-refresh { 
                border: none; 
                color: white; 
                border-radius: 10px; 
                padding: 10px 20px; 
                transition: 0.3s; 
            }
            .btn-submit {
                background-color: #c275e6;
            }
            .btn-submit:hover { 
                background-color: #d5a1ed; 
            }
            .btn-refresh { 
                background-color: #c275e6; 
            }
            .btn-refresh:hover { 
                background-color: #d5a1ed; 
            }
            .error-message { 
                display: none; 
                color: red; 
                font-size: 0.85em; 
            }
            input.error-input { 
                border: 1px solid red; 
            }
        </style>
    </head>
    <body class="p-4">
        <div class="container d-flex justify-content-center">
            <div class="card p-4 shadow" style="max-width: 600px; width: 100%;">
                <h4 class="card-title text-center mb-4">Sales Report</h4>
                <form id="salesReport" novalidate>
                    <div class="row mb-3">

                        <div class="col-md-6">
                            <label class="form-label">From Date <span style="color:red">*</span></label>
                            <input type="date" class="form-control form-control-sm" id="fromDate" name="fromDate">
                            <div id="fromDateError" class="error-message">Select a valid from Date</div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">To Date <span style="color:red">*</span></label>
                            <input type="date" class="form-control form-control-sm" id="toDate" name="toDate">
                            <div id="toDateError" class="error-message">Select a valid to Date</div>
                        </div>

                        <div class="text-center mt-3">
                            <button type="button" class="btn-submit me-2" onclick="showReport()">Show Report</button>
                            <button type="button" class="btn-refresh" onclick=" refresh()">Reset</button>
                        </div>

                    </div>
                </form>
                <div class="mt-4" id="resultForm"></div>
            </div>
        </div>
        <script>
                         $("#fromDate").on("input change",function(){
                             if(!$(this).val()) {
                                 $(this).addClass("error-input");
                                 $("#fromDateError").show();
                             } else{
                                 $(this).removeClass("error-input");
                                 $("#fromDateError").hide();
                             }
                         });
                         
                          $("#toDate").on("input change",function(){
                             if(!$(this).val()) {
                                 $(this).addClass("error-input");
                                 $("#toDateError").show();
                             } else{
                                 $(this).removeClass("error-input");
                                 $("#toDateError").hide();
                             }
                         });
                         
                         function showReport() {
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
                            
                            let data = $("#salesReport").serializeArray();
         
                            data.push({name: "id" , value: 1});
                            $.post("../../general/master/SalesReportInner.jsp" , data , function(response){
                                console.log(response)
                                $("#resultForm").html(response);
                            },"html");          
                       }
                       
                           function refresh(){
                               $("#salesReport")[0].reset();
                               $(".error-message").hide();
                               $("input").removeClass("error-input");
                               $("#resultForm").html("");
                           }
                           
            </script>
    </body>
</html>
