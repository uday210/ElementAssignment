/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
public class Element_getPaymentHistory{


    public static String getPaymentHistory(String relatedToId){
    
     try{
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Payment_History');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if(res.getStatuscode()==200)
            return res.getBody();
        else{
            //create custom error
            Element_HandleCustomException.LogException(res,relatedToId,'getPaymentHistory','Element_getPaymentHistory');
            } 
        } catch (Exception e) {
            Element_HandleCustomException.LogException(e);
        }
        
      return null;  
    }

}