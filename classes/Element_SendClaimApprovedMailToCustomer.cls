/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
global class Element_SendClaimApprovedMailToCustomer implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        //system.debug(database.query('SELECT id FROM contact WHERE Claim_Approved_on__c=TODAY'));

         return Database.getQueryLocator('SELECT id,Claim_Approved_on__c FROM contact WHERE Claim_Approved_on__c=TODAY AND Claim_Status__c=\'Approved\' ');
    }
    global void execute(Database.BatchableContext bc, List<Contact> Customers){
        // process each batch of records
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName ='Element_Claim_approved_notification'];
        List<Messaging.SingleEmailMessage> EmailMessages= new List<Messaging.SingleEmailMessage>();
        for(Contact eachCustomer:Customers){
            EmailMessages.add(Element_GenerateSingleEmailMessage.getEmailMessageForCUstomer(et.Id,eachCustomer.Id));
            eachCustomer.Claim_Approved_on__c  = null;
            
        }
        if(!EmailMessages.isEmpty())
        {
                Messaging.sendEmail(EmailMessages);
                Database.update(Customers,false);
        }
        
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}