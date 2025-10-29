package productForm;

import firstline.util.JSONExtendClass;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class ProductForm extends JSONExtendClass {

    public String funSaveProduct() {
        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();

        String productName = getRequest().getParameter("productName");

        long productId = 0L;
        long empId = 0L;
        ResultSet rsProd = null;
        boolean result = false;

        try {
            result = objTrans.beginTransaction();
            if (result) {
                String queryProd = "SELECT COALESCE(MAX(product_id),0)+1 AS nextproductid FROM productmaster";
                rsProd = firstline.dbo.FetchData.getResultSet(queryProd);
                if (rsProd.next()) {
                    productId = rsProd.getLong("nextproductid");
                }
                if (rsProd != null) {
                    rsProd.close();
                }
            }

            empId = getLlu().getEmployeeId();

            String insertQuery = "INSERT INTO productmaster (product_id, product_name, transaction_id, emp_id)"
                    + "VALUES (" + productId + ", '" + productName + "', 5445, " + empId + ")";

            System.out.println("Insert Query: " + insertQuery);
            System.out.println("empId: " + empId);
            result = objTrans.executeSQL(insertQuery);

            if (result) {
                objTrans.endTransaction();
                return "Product saved successfully!";
            } else {
                objTrans.rollbackTransaction();
                return "Failed to save product!";
            }

        } catch (SQLException e) {
            return "Error: " + e.getMessage();
        } finally {
            try {
                if (rsProd != null) {
                    rsProd.close();
                }
            } catch (SQLException ignored) {
            }
        }
    }

    public String funSaveSupplier() {

        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();
        String supplierName = getRequest().getParameter("supplierName");
        long supplierId = 0L;
        long empId = 0L;
        ResultSet rsProd = null;
        boolean result = false;

        try {
            result = objTrans.beginTransaction();
            if (result) {
                String queryProd = "SELECT COALESCE(MAX(supplier_id),0)+1 AS nextsupplierid FROM suppliermaster";
                rsProd = firstline.dbo.FetchData.getResultSet(queryProd);
                if (rsProd.next()) {
                    supplierId = rsProd.getLong("nextsupplierid");
                }
                if (rsProd != null) {
                    rsProd.close();
                }
            }

            empId = getLlu().getEmployeeId();

            String insertQuery = "INSERT INTO suppliermaster (supplier_id, supplier_name, transaction_id, emp_id) "
                    + "VALUES (" + supplierId + ", '" + supplierName + "', 5445, " + empId + ")";
            result = objTrans.executeSQL(insertQuery);

            if (result) {
                objTrans.endTransaction();
                return "Supplier saved successfully!";
            } else {
                objTrans.rollbackTransaction();
                return "Failed to save product!";
            }

        } catch (SQLException e) {
            return "Error: " + e.getMessage();
        } finally {
            try {
                if (rsProd != null) {
                    rsProd.close();
                }
            } catch (SQLException ignored) {
            }
        }
    }

    public List<Map<String, Object>> getProductList() throws Exception {

        String sql = "SELECT product_id, product_name FROM productmaster ORDER BY product_id";
        return firstline.dbo.FetchData.getResultSetListMap(sql);
    }

    public String updateProduct() {

        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();

        String productName = getRequest().getParameter("productName");
        String productId = getRequest().getParameter("productId");

        boolean result = false;
        try {
            result = objTrans.beginTransaction();

            if (result) {
                String query = "UPDATE productmaster SET product_name = '" + productName + "' WHERE product_id = " + productId;
                result = objTrans.executeSQL(query);
                if (result) {
                    objTrans.endTransaction();
                    return "Product updated successfully!";
                } else {
                    objTrans.rollbackTransaction();
                    return "Failed to update product!";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
        return "Update failed!";
    }

    public String deleteProduct() {
        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();

        String productId = getRequest().getParameter("productId");

        boolean result = false;
        try {
            result = objTrans.beginTransaction();

            if (result) {
                String query = "DELETE FROM productmaster WHERE product_id = " + productId;
                result = objTrans.executeSQL(query);
                if (result) {
                    objTrans.endTransaction();
                    return "Product deleted successfully!";
                } else {
                    objTrans.rollbackTransaction();
                    return "Failed to delete product!";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error: " + e.getMessage();
        }
        return "Delete failed!";
    }
}
