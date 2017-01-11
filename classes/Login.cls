public with sharing class Login {

    private static final String NS_SOAP = 'http://schemas.xmlsoap.org/soap/envelope/';
    private static final String NS_SF = 'urn:partner.soap.sforce.com';

    public static String login(String user,String password)
    {
        try{
            APIUser__c creds = APIUser__c.getInstance('API USER');
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');   
            req.setTimeout(60000);
            //String soapEndpointForLogin = System.Label.SOAPEndpointForLogin;
            if(creds != null){
                req.setEndpoint(creds.Endpoint__c+creds.Organization_Id__c);
            }
           /* else
                //req.setEndpoint('https://test.salesforce.com/services/Soap/u/36.0/');
                req.setEndpoint(soapEndpointForLogin);*/
            req.setHeader('Content-Type', 'text/xml;charset=UTF-8');        
            req.setHeader('SOAPAction', '""');
            req.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' +user+ '</username><password>' + password + '</password></login></Body></Envelope>');        
            HttpResponse res =  new Http().send(req);
            System.debug('res-->'+res.getBody());
            if(res.getStatusCode() != 200)
            {
                Dom.Document responseDocument = res.getBodyDocument();
                Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
                Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', NS_SOAP); // soapenv:Body 
                Dom.Xmlnode faultElm = bodyElm.getChildElement('Fault', NS_SOAP); // soapenv:Fault
                Dom.Xmlnode faultStringElm = faultElm.getChildElement('faultstring', NS_SF); // faultstring    
                System.debug('faultStringElm-->'+faultStringElm);
                throw new LoginException(faultStringElm.getText()); 
            }
            Dom.Document responseDocument = res.getBodyDocument();
            Dom.Xmlnode rootElm = responseDocument.getRootElement(); // soapenv:Envelope
            Dom.Xmlnode bodyElm = rootElm.getChildElement('Body', NS_SOAP); // soapenv:Body 
            Dom.Xmlnode loginResponseElm = bodyElm.getChildElement('loginResponse', NS_SF); // loginResponse
            Dom.Xmlnode resultElm = loginResponseElm.getChildElement('result', NS_SF); // result
            Dom.Xmlnode sessionIdElm = resultElm.getChildElement('sessionId', NS_SF); // sessionId
            System.debug('###RA'+sessionIdElm.getText());
            return sessionIdElm.getText();
        }
        catch(LoginException ex){
            return null;
        }
    }

    public class LoginException extends Exception {}
}