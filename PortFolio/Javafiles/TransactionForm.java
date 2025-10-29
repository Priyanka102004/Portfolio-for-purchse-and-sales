package transactionForm;

import firstline.util.JSONExtendClass;
import java.sql.*;
import java.sql.ResultSet;
import java.util.List;
/**
 *
 * @author Priyanka
 */
public class TransactionForm extends JSONExtendClass {

    public List getProduct() throws Exception {
        String strSQL = "SELECT product_id, product_name FROM productmaster "
                + "WHERE UCASE(TRIM(REPLACE(REPLACE(REPLACE(product_name,' ',''),'-',''),'.',''))) "
                + "LIKE UCASE(TRIM(REPLACE(REPLACE(REPLACE('%%','"+getFilter()+"',''),'-',''),'.','')))";

        return firstline.dbo.FetchData.getResultSetList(strSQL);
    }

    public List getSupplier() throws Exception {
        String strSQL = "SELECT supplier_id, supplier_name FROM suppliermaster "
                + "WHERE UCASE(TRIM(REPLACE(REPLACE(REPLACE(supplier_name,' ',''),'-',''),'.',''))) "
                + "LIKE UCASE(TRIM(REPLACE(REPLACE(REPLACE('%%',' ',''),'-',''),'.','')))";

        return firstline.dbo.FetchData.getResultSetList(strSQL);
    }

    public String funSaveProduct() {
        
        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();

        String productName = getRequest().getParameter("productName");
        
        String supplierName = getRequest().getParameter("supplier");
        
        double cost = Double.parseDouble(getRequest().getParameter("cost"));
        
        int qty = Integer.parseInt(getRequest().getParameter("Quantity"));
        
        double tax = Double.parseDouble(getRequest().getParameter("tax"));
        
        double sellingPrice = Double.parseDouble(getRequest().getParameter("sellingPrice"));

        long productId = 0L;
        long supplierId = 0L;
        long empId = 0L;
        long transactionId = 0L;
        ResultSet rs = null;

        try {
           
            if (!objTrans.beginTransaction()) {
                return "Failed to start transaction!";
            }

           
            String prodQuery = "SELECT product_id FROM productmaster WHERE product_name = '" + productName + "'";
            rs = firstline.dbo.FetchData.getResultSet(prodQuery);
            if (rs.next()) {
                productId = rs.getLong("product_id");
            } else {
                return "Product not found!";
            }
            rs.close();

           
            String supQuery = "SELECT supplier_id FROM suppliermaster WHERE supplier_name = '" + supplierName + "'";
            rs = firstline.dbo.FetchData.getResultSet(supQuery);
            if (rs.next()) {
                supplierId = rs.getLong("supplier_id");
            } else {
                return "Supplier not found!";
            }
            rs.close();

            
            empId = getLlu().getEmployeeId();

          
            String tranQuery = "SELECT COALESCE(MAX(transaction_id),0)+1 AS nextTransactionId FROM transactionmaster";
            rs = firstline.dbo.FetchData.getResultSet(tranQuery);
            if (rs.next()) {
                transactionId = rs.getLong("nextTransactionId");
            }
            rs.close();

            String insertQuery = "INSERT INTO transactionmaster "
                    + "(product_id, supplier_id, emp_id, cost, quantity, tax_percent, selling_price) "
                    + "VALUES (" + productId + ", " + supplierId + ", " + empId + ", "
                    + cost + ", " + qty + ", " + tax + ", " + sellingPrice + ")";



            System.out.println("Insert Query: " + insertQuery);

            boolean result = objTrans.executeSQL(insertQuery);

            if (result) {
                objTrans.endTransaction();
                return "Transaction saved successfully!";
            } else {
                System.out.println("Execute result: " + result);
                objTrans.rollbackTransaction();
                return "Failed to save transaction!";
            }

        } catch (Exception e) {
            try {
                objTrans.rollbackTransaction();
            } 
            catch (Exception ignored) {
            }
            return "Error: " + e.getMessage(); 
        } 
        finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } 
            catch (SQLException ignored) {
            }
        }
    }
}
