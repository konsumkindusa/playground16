/**************************************************************************************
Apex Class Name  : Test_SOAPReusableMockResponse
Description      : This is used in all the test classes that cover the webservice callouts.
                   It sets a mock response, so that the test method do not fail.
                   
* Developer         Date                   Description
* ----------------------------------------------------------------------------                 
* Sirisha Kodi      Feb 3 2015           Original Version
*************************************************************************************/
@isTest
global class Test_SOAPReusableMockResponse implements WebServiceMock {
   
   protected Object responseOBJ;
   //constructor
   public Test_SOAPReusableMockResponse(Object responseOBJ){
   	this.responseOBJ = responseOBJ; 
   }
   
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
      			response.put('response_x', responseOBJ); 
       			system.debug('*** response '+response);
   }
}