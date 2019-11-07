/*****************
*Author : Uday
*Date : 06/11/2019
*Description : This batch class is scheduled to run once in every day 
*******************/
global class Element_SendClaimApprovedMailToCustomer implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //system.debug(database.query('SELECT id FROM contact WHERE Claim_Approved_on__c=TODAY'));
         /**
         get the Customers(Contact) records whose claim status is APPROVED and which is Approved on the day of batch running 
         (so this batch needs to be scheduled to run at the EOD
         **/ 
         return Database.getQueryLocator('SELECT id,Claim_Approved_on__c FROM contact WHERE Claim_Approved_on__c=TODAY AND Claim_Status__c=\'Approved\' ');
    }
    global void execute(Database.BatchableContext bc, List<Contact> Customers){
        
        // process each batch of records
        
        //get the email template
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName ='Element_Claim_approved_notification'];
        
        //initilize the emails list
        List<Messaging.SingleEmailMessage> EmailMessages= new List<Messaging.SingleEmailMessage>();
        
        //iterate on each customer(Contact) and generate email and populate the 'Claim_Approved_on__c' with null so it wont be picked again once the email is 
        for(Contact eachCustomer:Customers){
            EmailMessages.add(Element_GenerateSingleEmailMessage.getEmailMessageForCUstomer(et.Id,eachCustomer.Id));
            eachCustomer.Claim_Approved_on__c  = null;
            
        }
        if(!EmailMessages.isEmpty())
        {
          try{
           Messaging.sendEmail(EmailMessages);
           //once the email is send update the customers (contacts)
            } catch (Exception e) {
            Element_HandleCustomException.LogException(e);
            }  
           Database.update(Customers,false);
        }
        
        
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}