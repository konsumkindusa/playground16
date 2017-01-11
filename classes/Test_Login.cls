@isTest
public class Test_Login {

    public static testmethod void testSoapLogin(){
        Test.setMock(HttpCalloutMock.class, new Test_LoginWebserviceCalloutMock());
        Test.startTest();
        Test_LoginWebserviceCalloutMock.stCode=200;
      	Login.login('raushghajm@wer.com','CFdg');
        Test.stopTest();
    }
    public static testmethod void testSoapLoginFailure(){
        APIUser__c creds = new APIUser__c();
        creds.Username__c = 'raushghajm@wer.com';
        creds.Password__c='cdfd';
        creds.Endpoint__c='https://test.com';
        creds.Name='API USER';
        creds.Organization_Id__c='09853567896568';
        creds.Security_Token__c='23456787ytrdfyu';
        INSERT creds;
        Test.setMock(HttpCalloutMock.class, new Test_LoginWebserviceCalloutMock());
        Test.startTest();
        Test_LoginWebserviceCalloutMock.stCode=100;
      	Login.login('raushghajm@wer.com','CFdg');
        Test.stopTest();
    }
}