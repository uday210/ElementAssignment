@isTest
private class Element_PaymentDataCtrlTest{

    @testSetup static void setup() {
    
        Case ca = new Case(Subject='Test Claim request');
        insert ca;


    }
    @isTest static void testCalloutWithStaticResources() {
        // Use StaticResourceCalloutMock built-in class to
        // specify fake response and include response body 
        // in a static resource.
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('payments');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            List<Element_PaymentHistoryParser> parseddata = Element_PaymentDataCtrl.getPaymentsData([select id from case limit 1].id);
            system.assert(parseddata.size()==3);
            system.assert([select count() from CustomException__c]==0);
          Test.stopTest();
        }
        
     @isTest static void testCalloutWith400statuscode() {
        // Use StaticResourceCalloutMock built-in class to
        // specify fake response and include response body 
        // in a static resource.
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('payments');
        mock.setStatusCode(400);
        mock.setHeader('Content-Type', 'application/json');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            List<Element_PaymentHistoryParser> parseddata = Element_PaymentDataCtrl.getPaymentsData([select id from case limit 1].id);
            system.assert(parseddata==null);
            system.assert([select count() from CustomException__c]==1);
            system.assertEquals([select Exception_Type__c from CustomException__c limit 1 ].Exception_Type__c,'400');
          Test.stopTest();
        }    
}