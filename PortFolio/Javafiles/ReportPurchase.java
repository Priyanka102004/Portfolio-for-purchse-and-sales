package ReportPurchase;

import firstline.util.JSONExtendClass;
import java.util.List;

import net.sf.json.JSONObject;

public class ReportPurchase extends JSONExtendClass {

    public List getTransactionReport() throws Exception {
        String query = "SELECT t.transaction_id, p.product_name, s.supplier_name, "
                + "t.quantity, t.cost, t.tax_percent, t.selling_price, t.transactiondatetime "
                + "FROM transactionmaster t "
                + "LEFT JOIN productmaster p ON t.product_id = p.product_id "
                + "LEFT JOIN suppliermaster s ON t.supplier_id = s.supplier_id "
                + "WHERE 1=1 "
                + "ORDER BY t.transactiondatetime DESC";

        return firstline.dbo.FetchData.getResultSetList(query);
    }

    public List getGenerateReport() {

        boolean result = false;
        firstline.transactions.Transactions objClass = new firstline.transactions.Transactions();
        JSONObject returnObj = new JSONObject();

        String query = "";
        try {
            String fromDate = getRequest().getParameter("fromDate");
            String toDate = getRequest().getParameter("toDate");

            result = objClass.beginTransaction();

            if (result) {
                
                query = "SELECT t.transaction_id, p.product_name, s.supplier_name, "
                        + "t.quantity, t.cost, t.tax_percent, t.selling_price, t.transactiondatetime "
                        + "FROM transactionmaster t "
                        + "LEFT JOIN productmaster p ON t.product_id = p.product_id "
                        + "LEFT JOIN suppliermaster s ON t.supplier_id = s.supplier_id "
                        + "WHERE t.transactiondatetime::date BETWEEN TO_DATE('" + fromDate + "','YYYY-MM-DD') "
                        + "AND TO_DATE('" + toDate + "','YYYY-MM-DD')";

                objClass.endTransaction();

            }
            
        } catch (Exception e) {
            e.printStackTrace();
            objClass.rollbackTransaction();
        }
        return firstline.dbo.FetchData.getResultSetListMap(query);
    }
}
