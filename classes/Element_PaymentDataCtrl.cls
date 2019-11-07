public class Element_PaymentDataCtrl {
    
    @AuraEnabled
    public static  List<Element_PaymentHistoryParser>  getPaymentsData(){
        
        return Element_PaymentHistoryParser.parse(Element_getPaymentHistory.getPaymentHistory());

    }

}