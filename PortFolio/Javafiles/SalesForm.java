/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package SalesForm;

import java.util.List;
import firstline.util.JSONExtendClass;
import net.sf.json.JSONObject;

/**
 *
 * @author Priyanka
 */
public class SalesForm extends JSONExtendClass {

    
    public List getSales() throws Exception {
        String filter = getFilter();
        String strSQL = "SELECT product_id, product_name FROM productmaster "
                + "WHERE UPPER(TRIM(REPLACE(REPLACE(REPLACE(product_name, ' ', ''), '-', ''), '.', ''))) "
                + "LIKE UPPER(TRIM(REPLACE(REPLACE(REPLACE('%" + filter + "%', ' ', ''), '-', ''), '.', '')))";
        return firstline.dbo.FetchData.getResultSetList(strSQL);
    }

   
    public String funsaveForm() {
        
        boolean blnResult = false;            
        firstline.transactions.Transactions objTrans = new firstline.transactions.Transactions();
        JSONObject returnObj = new JSONObject();
        
        String result = "Save failed";

        try {
          
            int productId = Integer.parseInt(getRequest().getParameter("productId"));
            
            int quantity = Integer.parseInt(getRequest().getParameter("quantity"));
            
            double salesPrice = Double.parseDouble(getRequest().getParameter("salesPrice"));
            
            double tax = Double.parseDouble(getRequest().getParameter("tax"));
            
            double discount = Double.parseDouble(getRequest().getParameter("discount"));
            
            double totalAmount = Double.parseDouble(getRequest().getParameter("totalAmount"));

         
            long empId = 1;
            
            blnResult = objTrans.beginTransaction();
            
            
          if(blnResult){
            String insertSQL = "INSERT INTO salesmaster "
                    + "(product_id, emp_id, quantity, sales_price, tax_percent, discount_percent, total_amount) "
                    + "VALUES (" + productId + ", " + empId + ", " + quantity + ", "
                    + salesPrice + ", " + tax + ", " + discount + ", " + totalAmount + ")";
            
            System.out.println(insertSQL);
            
           blnResult = objTrans.executeSQL(insertSQL);
    
          }

           
        } catch (Exception e) {
            e.printStackTrace();
            objTrans.rollbackTransaction();
        }
        
        if(blnResult){
            returnObj.put("code", "1");
            returnObj.put("msg", "Saved Successfully");
            
             objTrans.endTransaction();
        }else{
             returnObj.put("code", "0");
           returnObj.put("msg", "Save Failed");
            objTrans.rollbackTransaction();
        }
        
        return returnObj.toString();
        
    }
}
