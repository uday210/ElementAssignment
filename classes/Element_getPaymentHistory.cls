/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
public class Element_getPaymentHistory{


    public static String getPaymentHistory(){
    
     try{
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Payment_History');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res.getBody();
        
        } catch (Exception e) {
            Element_HandleCustomException.LogException(e);
        }
        
      return null;  
    }

}