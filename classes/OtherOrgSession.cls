public class OtherOrgSession{

    public String SessionIdis{get;set;}
    public OtherOrgSession(){
    
        SessionIdis = DoUserLogin();
    
    }

    
    public static String DoUserLogin() {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('POST');
        String userName ='uday_sfdc@dealreg.com';
        String Password_token = 'Bussas210210!kUi6lfTYNrxthg5GuOwNxn3q';
        String Body = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com"><soapenv:Body><urn:login><urn:username>'+userName+'</urn:username><urn:password>'+Password_token+'</urn:password></urn:login></soapenv:Body></soapenv:Envelope>';
        req.setHeader('Content-Type', 'text/xml');
        req.setHeader('SOAPAction', 'test');
        req.setBody(Body);
        req.setEndpoint('https://login.salesforce.com/services/Soap/c/40.0');
        HttpResponse res=  http.send(req);
        System.debug(res.getbody());
        XMLParserClass x = new XMLParserClass();
x.parserXML(res.getbody());
system.debug(x.xmlDataMap );
        return  x.xmlDataMap.get('sessionId');//[1].split('</sessionId>')[0];
      // return '';
    }
}