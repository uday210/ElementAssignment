@isTest
public class ElementSendClaimApprovedMail_Test{
     static testmethod void ProcessbatchForSendingEmails() {
         Element_TestDataUtil.getBulkContacts();
         system.assertEquals([select count() from contact],197);
         
         Test.startTest();
              Id batchId = Database.executeBatch(new Element_SendClaimApprovedMailToCustomer());
         Test.stopTest();
         AsyncApexJob EmailJob = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:batchId ];
         system.assert(EmailJob .status.toLowerCase()=='completed');
         system.assertEquals([select count() from contact where Claim_Status__c='Approved' and Claim_Approved_on__c=null],29);
     }  
}