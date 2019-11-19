public class Element_PaymentDataCtrl {
    
    @AuraEnabled
    public static  List<Element_PaymentHistoryParser>  getPaymentsData(String relatedToId){
        
        return Element_PaymentHistoryParser.parse(Element_getPaymentHistory.getPaymentHistory(relatedToId));
        
    }
    @AuraEnabled
    public static list<Element_paymentData.paymentInfo> getSoapPaymentData(){
        Element_paymentData.SessionHeader_element  ssid = new Element_paymentData.SessionHeader_element();
        ssid.sessionId = new OtherOrgSession().SessionIdis;
            //'00D6F000001omOM!AQQAQN4C3L0amDDArENzQ_plv0vNHWm1lCvoMS_QihHF7VIKq.IxXhqT6bcll7S_fZt6YLgqCTSgLsNrFjPg_DoXjU0h9yyY';
        
        Element_paymentData.PaymentData  Pi = new Element_paymentData.PaymentData();
        Pi.SessionHeader = ssid;
        system.debug( Pi.getPaymetInformationData());
        return Pi.getPaymetInformationData();
    }
    
}