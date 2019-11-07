/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
public class Element_GenerateSingleEmailMessage{


    /*
    *Param 1 :Email Template Id
    *Param 2 :Customer Id
    */
    
    public static Messaging.SingleEmailMessage getEmailMessageForCUstomer(String TemplateId,String RecepientId){
    
       try{     
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(TemplateId);
            /***https://help.salesforce.com/articleView?id=000323568&language=en_US&type=1&mode=1***/
            //if setTargetObjectId is USER id it wont counts towards the Daily limit of single email messages
            mail.setTargetObjectId(RecepientId);
            mail.setSaveAsActivity(true);
            return mail;
         } catch (Exception e) {
            Element_HandleCustomException.LogException(e);
        } 
       
      return null;
    }
}