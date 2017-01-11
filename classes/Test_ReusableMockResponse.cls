/**************************************************************************************
Apex Class Name  : Test_ReusableMockResponse
Description      : This is used in all the test classes that cover the webservice callouts.
                   It sets a mock response, so that the test method do not fail.
                   
* Developer         Date                   Description
* ----------------------------------------------------------------------------                 
* Sirisha Kodi      Oct 23 2015           Original Version
*************************************************************************************/
@isTest
public class Test_ReusableMockResponse implements HttpCalloutMock {

    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Blob bodyAsBlob;
    protected Map < String, String > responseHeaders;
    //conatructor
    public Test_ReusableMockResponse(Integer code, String status, String body, Map < String, String > responseHeaders) {

        this.code = code;
        this.status = status;
        this.bodyAsString = body;
        this.bodyAsBlob = null;
        this.responseHeaders = responseHeaders;

    }
    // This is an overriden global interface method, that has to be defined when HttpCalloutMock Interface is implemented.
    public HTTPResponse respond(HTTPRequest req) {

        HttpResponse response = new HttpResponse();
        response.setStatusCode(code);
        response.setStatus(status);
        if (bodyAsBlob != null) {
            response.setBodyAsBlob(bodyAsBlob);
        } else {
            response.setBody(bodyAsString);
        }

        if (responseHeaders != null) {
            for (String key: responseHeaders.keySet()) {
                response.setHeader(key, responseHeaders.get(key));
            }
        }
        system.debug('***Response***'+ response);
        system.debug('Response Body'+ response.getBody());
        return response;

    }
}