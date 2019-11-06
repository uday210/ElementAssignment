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
    
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(TemplateId);
        mail.setTargetObjectId(RecepientId);//primaryContact);
      //  mail.setWhatId(RecepientId);
        mail.setSaveAsActivity(true);
  
        return mail;
    
    }
}