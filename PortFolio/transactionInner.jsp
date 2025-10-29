<%-- 
    Document   : productMasterInner
    Created on : Sep 30, 2025, 2:11:51 PM
    Author     : Priyanka
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="obj" scope="request" class="transactionForm.TransactionForm" />
<c:set target="${obj}" property="request" value="${pageContext.request}" />

<c:choose>

   
    <c:when test="${param.id == '1'}">
        <%= obj.funSaveProduct()%>
    </c:when>
    
    <c:when test="${param.ids eq 4}">
        <c:set var="rowlist" value="${obj.product}"/>
        <table style="width: 100%;" cellpadding="5" cellspacing="0" class="ui-widget-content">
            <thead class="ui-widget-header">
                <tr class="ui-widget-header">
                    <td>Product Name</td>
                    <td style="cursor: pointer" align="right" onclick="funCloseDivs(this)">
                        <img src="../../resources/icons/cross.gif" alt="close"> 
                    </td>
                </tr>
            </thead>
        </table>

        <div style="overflow: auto; height: 150px;">
            <table style="width:100%" cellpadding="5" cellspacing="0">
                    <c:forEach var="rows" items="${rowlist}" varStatus="status">
                        <c:set var="columnList" value="${rows}" />
                        <tr style="cursor: pointer"  onclick="selectAppSubmData(this)" id="${columnList[0]}" title="${columnList[1]}">
                            <c:forEach var="columns" items="${columnList}" begin="1">
                                <td width="100%">${columns}</td>
                            </c:forEach>
                        </tr>    
                    </c:forEach>
            </table>
        </div>
    </c:when>
     <c:when test="${param.ids eq 5}">
        <c:set var="rowlist" value="${obj.supplier}"/>
        <table style="width: 100%;" cellpadding="5" cellspacing="0" class="ui-widget-content">
            <thead class="ui-widget-header">
                <tr class="ui-widget-header">
                    <td>Supplier Name</td>
                    <td style="cursor: pointer" align="right" onclick="funCloseDivs(this)">
                        <img src="../../resources/icons/cross.gif" alt="close"> 
                    </td>
                </tr>
            </thead>
        </table>

        <div style="overflow: auto; height: 150px;">
            <table style="width:100%" cellpadding="5" cellspacing="0">
                    <c:forEach var="rows" items="${rowlist}" varStatus="status">
                        <c:set var="columnList" value="${rows}" />
                        <tr style="cursor: pointer"  onclick="selectAppSubmData(this)" id="${columnList[0]}" title="${columnList[1]}">
                            <c:forEach var="columns" items="${columnList}" begin="1">
                                <td width="100%">${columns}</td>
                            </c:forEach>
                        </tr>    
                    </c:forEach>
            </table>
        </div>
    </c:when>    
</c:choose>
