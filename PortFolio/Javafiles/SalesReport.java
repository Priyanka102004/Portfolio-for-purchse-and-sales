/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SalesReport;
import firstline.util.JSONExtendClass;
import java.util.List;
import net.sf.json.JSONObject;

public class SalesReport extends JSONExtendClass{
    
     public List getSalesReport() throws Exception {
         
         String query = "SELECT s.sales_id ,p.product_name , "
                 + "s.quantity, s.sales_price, s.tax_percent, discount_percent, total_amount,s.salesdatetime"
                 + " FROM salesmaster s "
                 + "LEFT JOIN productmaster p ON s.product_id = p.product_id "
                 + "WHERE 1=1 "
                 + "ORDER BY s.salesdatetime DESC";
        return  firstline.dbo.FetchData.getResultSetList(query);
    }
     
     public List getshowReport(){
         
        boolean result = false;
        firstline.transactions.Transactions objClass = new firstline.transactions.Transactions();
        JSONObject returnObj = new JSONObject();

        String query = "";
        
        try {
            String fromDate = getRequest().getParameter("fromDate");
            String toDate = getRequest().getParameter("toDate");

            result = objClass.beginTransaction();
        if (result) {
                query = "SELECT s.sales_id, p.product_name, "
                        + "s.quantity, s.sales_price, s.tax_percent, s.discount_percent,total_amount, s.salesdatetime "
                        + "FROM salesmaster s "
                        + "LEFT JOIN productmaster p ON s.product_id = p.product_id "
                        + "WHERE s.salesdatetime::date BETWEEN TO_DATE('" + fromDate + "','YYYY-MM-DD') "
                        + "AND TO_DATE('" + toDate + "','YYYY-MM-DD')"; 

                
            objClass.endTransaction();

        }
        
        } 
          catch (Exception e){
          e.printStackTrace();
          objClass.rollbackTransaction();
          }
         return firstline.dbo.FetchData.getResultSetListMap(query);
     }
}

