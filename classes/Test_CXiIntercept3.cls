@isTest
public with sharing class Test_CXiIntercept3 {
	@isTest
	private static void CXiIntercept31(){
			ApexPages.currentPage().getParameters().put('id', '-E803-1111-ZRKEN00000000A');
			String sampleResponse = '<?xml version="1.0" encoding="utf-8"?>' + 
            '<PaymetricResponse xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">' + 
                '<Fields>' + 
                    '<FormField>' + 
                        '<Name>PaymentCreditCard</Name>' + 
                        '<Value>-E803-1111-ZRKEN00000000A</Value>' + 
                        '<IsToTokenize>true</IsToTokenize>' + 
                    '</FormField>' + 
                '</Fields>' + 
                '<ResponsePacket><AccessToken>ABCDEFGH1234</AccessToken></ResponsePacket>' + 
            '</PaymetricResponse>';
            Test_ReusableMockResponse fakeResponse = new Test_ReusableMockResponse(200,'SUCCESS',sampleResponse, new map<String,String>{'Content-Type'=>'application/json'});
			Test.setMock(HttpCalloutMock.class, fakeResponse); 
			
			CXiIntercept3 controller1 = new CXiIntercept3();
			controller1.getXiInterceptURL();
			controller1.getXiInterceptGUID();
			controller1.getXiInterceptPSK();
			controller1.getAccessToken();
			controller1.getCreditCardToken();
	}
}