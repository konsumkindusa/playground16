/**
*       @author Vishal Negandhi
*       @date   15/01/2015  
        @description   Test Class for covering the ContactPersonProcessingRequest.
        Modification Log:
        ------------------------------------------------------------------------------------
        Developer                       Date                Description
        ------------------------------------------------------------------------------------
        Vishal Negandhi                 15/01/2015          Created
                  
**/
@isTest(SeeAllData = False)
public with sharing class Test_ContactPersonProcessingRequest {
    
    @isTest
    private static void request1(){
        ContactPersonProcessingRequest req = new ContactPersonProcessingRequest();
        ContactPersonProcessingRequest.ContactPersonQuery_Sync cpq_s;
    }
}