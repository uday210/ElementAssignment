public class Element_PaymentDataCtrl {
    
    @AuraEnabled
    public static  List<Element_PaymentHistoryParser>  getPaymentsData(String relatedToId){
        
        return Element_PaymentHistoryParser.parse(Element_getPaymentHistory.getPaymentHistory(relatedToId));

    }

}