<%-- 
    Document   : ReportPurchaseInner
    Created on : Oct 14, 2025, 2:36:53 PM
    Auth align="center"or     : Priyanka
--%>

<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="net.sf.jasperreports.engine.JRRuntimeException"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="obj" scope="request" class="ReportPurchase.ReportPurchase" />
<c:set target="${obj}" property="request" value="${pageContext.request}" />
<c:set var="isDataAvailable" value="false"/> 

<c:choose>
    <c:when test="${param.id == '1'}">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th align="center"> P.Name </th>
                    <th align="center"> S.Name </th>
                    <th align="center"> Qty </th>
                    <th align="center"> Cost </th>
                    <th align="center"> Tax % </th>
                    <th align="center"> SP </th>

                </tr>
            </thead>
            <tbody>
                <c:set var="rowlist" value="${obj.getGenerateReport()}"/>                             
                <c:set var="slno" value="0"/>
                <c:forEach var="rows"  items="${rowlist}" varStatus="status">
                    <c:set var="slno" value="${slno+1}"/>
                    <c:set var="columnlist" value="${rows}"/>
                    <c:set var="isDataAvailable" value="true"/> 
                    <tr style="cursor: pointer;">

                        <td align="center">${columnlist.product_name}</td>
                        <td align="center">${columnlist.supplier_name}</td>
                        <td align="center">${columnlist.quantity}</td>
                        <td align="center">${columnlist.cost}</td>
                        <td align="center">${columnlist.tax_percent}</td>
                        <td align="center">${columnlist.selling_price}</td>
                    </tr>   
                </c:forEach>

                <c:if test="${isDataAvailable eq false}">
                    <tr>
                        <td align="center" colspan="10">
                            No data found!
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </c:when>
    <c:when test="${param.id == '2'}">
        <%
            try {
                Map parameters = new HashMap();
                String fromDate = request.getParameter("fromDate");

                String toDate = request.getParameter("toDate");
                parameters.put("fromDate", fromDate);
                parameters.put("toDate", toDate);
                File reportFile = new File(application.getRealPath("/general/report/jrxml/report1.jasper"));
                System.out.println("reportFile" + reportFile);
                if (!reportFile.exists()) {
                    throw new JRRuntimeException("File WebappReport.jasper not found. The report design must be compiled first.");
                }
                byte[] bytes
                        = JasperRunManager.runReportToPdf(
                                reportFile.getPath(),
                                parameters,
                                //new WebappDataSource()
                                firstline.dbo.DbConnection.getConn()
                        );
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream ouputStream = response.getOutputStream();
                ouputStream.write(bytes, 0, bytes.length);
                ouputStream.flush();
                ouputStream.close();
            } catch (Exception e) {
                System.out.println("Error in Purchase Report=" + e.toString());
            }

        %>
    </c:when>
</c:choose>
