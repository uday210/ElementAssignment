/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
public class Element_PaymentHistoryParser {
    @AuraEnabled
    public String Payment_Date {get;set;} 
    @AuraEnabled
    public String Amount {get;set;} 
    @AuraEnabled
    public String Account_Number {get;set;} 

    public Element_PaymentHistoryParser(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'Payment Date') {
                        Payment_Date = parser.getText();
                    } else if (text == 'Amount') {
                        Amount = parser.getText();
                    } else if (text == 'Account Number') {
                        Blob key = Crypto.generateAesKey(128);
                        Blob data = Blob.valueOf(parser.getText());
                        Account_Number = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', key, data));//.toString();
                        
                    } else {
                        System.debug(LoggingLevel.WARN, 'Element_PaymentHistoryParser consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }
    
    
    public static List<Element_PaymentHistoryParser> parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return arrayOfElement_PaymentHistoryParser(parser);
    }
    
    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }
    
    private static List<Element_PaymentHistoryParser> arrayOfElement_PaymentHistoryParser(System.JSONParser p) {
        List<Element_PaymentHistoryParser> res = new List<Element_PaymentHistoryParser>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Element_PaymentHistoryParser(p));
        }
        return res;
    }




}