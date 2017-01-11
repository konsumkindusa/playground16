global class Test_LoginWebserviceCalloutMock implements HttpCalloutMock {
	public static INTEGER stCode;
    global HTTPResponse respond(HTTPRequest req) {
    	HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if(stCode == 200)
        	res.setBody('<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><loginResponse><result><metadataServerUrl>https://login.salesforce.com</metadataServerUrl><passwordExpired>false</passwordExpired><sandbox>false</sandbox><serverUrl>login.salesforce.com</serverUrl><sessionId>00Dm00000004gP9!ARsAQOfI7hs40XzJ6l7xJrs0eTIIhU1N5kV3tBfCGeRYy1egCmEEHH9Io0F1dGT7eLmnJkmhGt8vpXF4QwcMVn6lJlNMprlJ</sessionId><userId></userId><userInfo><accessibilityMode>false</accessibilityMode><currencySymbol xsi:nil="true"/><orgAttachmentFileSizeLimit>5242880</orgAttachmentFileSizeLimit><orgDefaultCurrencyIsoCode xsi:nil="true"/><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>098765766567578</organizationId><organizationMultiCurrency>true</organizationMultiCurrency><organizationName>IDEXX Laboratories</organizationName><profileId>12345678766543234</profileId><roleId xsi:nil="true"/><sessionSecondsValid>7200</sessionSecondsValid><userDefaultCurrencyIsoCode>USD</userDefaultCurrencyIsoCode><userEmail>rauanand@deloitte.com</userEmail><userFullName>Test</userFullName><userId>0987654312we46789</userId><userLanguage>en_US</userLanguage><userLocale>en_US</userLocale><userName>test@test.com</userName><userTimeZone>America/New_York</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></userInfo></result></loginResponse></soapenv:Body></soapenv:Envelope>');
        else
        	res.setBody('<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><soapenv:Fault><faultstring>Failure Response Code</faultstring></soapenv:Fault></soapenv:Body></soapenv:Envelope>');
        res.setStatusCode(stCode);
        return res;
    }
}