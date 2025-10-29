<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="productForm.ProductForm" %>
<%@ page import="java.util.List, java.util.Map" %>
<jsp:useBean id="productObj" class="productForm.ProductForm" scope="request"/>
<c:set target="${productObj}" property="request" value="${pageContext.request}" />

<c:choose>
    <c:when test="${param.id == 1}">
        <%=productObj.funSaveProduct()%>
    </c:when>
    <c:when test="${param.id == 2}">
        <%=productObj.funSaveSupplier()%>
    </c:when>

    <c:when test="${param.action eq 'view'}">
        <%
            List<Map<String, Object>> productList = productObj.getProductList();
            request.setAttribute("productList", productList);
        %>
        <table>
            <c:forEach var="p" items="${productList}">
                <tr data-id="${p.product_id}" style="cursor: pointer">
                    <td  onclick="editProduct('${p.product_name}' ,${p.product_id})">${p.product_name}</td>
                    <td>
                        <button type="button"  class="btn btn-sm btn-light" onclick="editProduct('${p.product_name}' ,${p.product_id})"${p.product_name}>Edit</button>
                        <button type="button"  class="btn btn-sm btn-light" onclick="deleteProduct(this)">Delete</button>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <c:if test="${empty productList}">
            <tr><td colspan='2'>No records found</td></tr>
        </c:if>

    </c:when>
    <c:when test="${param.id == 3}">
        <%=productObj.updateProduct()%>
    </c:when>
    <c:when test="${param.action eq 'delete'}">
        <%=productObj.deleteProduct()%>
    </c:when>
            
            
</c:choose>







