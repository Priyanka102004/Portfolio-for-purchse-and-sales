<%-- 
    Document   : SalesReportInner
    Created on : Oct 23, 2025, 11:26:49 AM
    Author     : Priyanka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="obj" scope="request" class="SalesReport.SalesReport" />
<c:set target="${obj}" property="request" value="${pageContext.request}"/>
<c:set var="isDataAvailable" value="false"/> 
<c:choose>
    <c:when test="${param.id == '1'}">
        <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th> P.Name </th>
                <th> Qty </th>
                <th> SP </th>
                <th> Tax % </th>
                <th>Discount %</th>
                <th>Total Amount</th>
           </tr>
        </thead>
          <c:set var="rowlist" value="${obj.getshowReport()}"/>                             
                <c:set var="slno" value="0"/>
                <c:forEach var="rows"  items="${rowlist}" varStatus="status">
                     <c:set var="slno" value="${slno+1}"/>
                     <c:set var="columnlist" value="${rows}"/>
                     <c:set var="isDataAvailable" value="true"/> 

                      <tr style="cursor: pointer;">
                        
                        <td align="center">${columnlist.product_name}</td>
                        <td align="center">${columnlist.quantity}</td>
                        <td align="center">${columnlist.sales_price}</td>
                        <td align="center">${columnlist.tax_percent}</td>
                        <td align="center">${columnlist.discount_percent}</td>
                        <td align="center">${columnlist.total_amount}</td>
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
</c:choose>


