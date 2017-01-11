/* Class Name  : InboundSearch_phonelookup
* Description : Controller class which services inbound telephonic events. Called via InboundSearch vf page.
* Created By  : Anudeep Gopagoni
* Created On  : 02-19-2016
*
* Modification Log:  
* --------------------------------------------------------------------------------------------------------------------------------------
* Developer              Date                   Modification ID       Description 
* ---------------------------------------------------------------------------------------------------------------------------------------
* Anudeep Gopagoni       02-19-2016             n/a                   Initial Version
* Anudeep Gopagoni       02-20-2016             1001                  replaced inbound_number with SF_SearchValue 
* Anudeep Gopagoni       02-25-2016             1002                  Removed System debug statements
*/

public with sharing class InboundSearch_phonelookup {
    
    public ApexPages.StandardController controller {get;set;}
    public String matchedAccountId {get;set;} //To store the found account's Id
    public Account matchedAccount {get;set;}
    public String matchedAccountName {get;set;} //To store the found account's Name
     public String matchedAccountIcon {get;set;} 
    public List<Account> accountId {get;set;}
    public List<Account> accList {get;set;}
    public string errorMsg {get;set;}    
    public String searchquery {get;set;} //String to store search results when user clicks search button
    public string inboundDID {get;set;}
    public List<Phone_Lookup__c> returnedPhoneLookups {get;set;}
    public List<List<SObject>> searchResultsBasedOnDid1 {get;set;}
    public string phoneNumberConverted {get;set;}
    //public String inbound_SF_SearchValue {get;set;}
    public List<Phone_Lookup__c> phoneLookups {get;set;}
    
    
    @TestVisible private string SF_SearchValue {get;set;}
    
    public InboundSearch_phonelookup(ApexPages.StandardController controller) {
        try{
            phoneLookups = new List<Phone_Lookup__c>();
            //Initializing boolean variable
            this.controller = controller;
            returnedPhoneLookups = new List<Phone_Lookup__c>();
            searchResultsBasedOnDid1 = new List<List<SObject>>();
            inboundDID = ApexPages.currentPage().getParameters().get('SF_SearchValue');
            phoneNumberConverted = inboundDID.replaceAll('(?i)[^a-z0-9]', '');
            accountId = new List<Account>();
            accList= new List<Account>();
            
            //Given that we have an SF_SearchValue and it is of sufficient length:
            if ((phoneNumberConverted!= null)) {
                //we will attempt to locate the account by:
                //  Phone_Lookup__c.Phone_Number__c -- or --
                performAllPhoneNumberSearchesFromPhoneLookup();
            }
            
        }catch(Exception ex) {
            errorMsg = ex.getMessage();
        }
    }
    
    /***********************************************************************************************
* performAllPhoneNumberSearchesFromPhoneLookup:
* This function handles the logic to search for
* a complete match on the Phone_Lookup__c for the inboundDid. 
***********************************************************************************************/ 
    
    
    public void performAllPhoneNumberSearchesFromPhoneLookup() {
        //Perform SOSL queries against Account and Phone_Lookup__c objects. SOSL is used as it is more 
        //relaxed in its requirements for formatting and vanity characters.
        //Related link: https://developer.salesforce.com/forums/?id=906F000000090gaIAA 
        searchResultsBasedOnDid1 = 
            [FIND :phoneNumberConverted IN ALL FIELDS 
             RETURNING
             Phone_Lookup__c (Account__c ,Account_Name__c,Phone_Number__c, SAP_Customer_Number__c WHERE Phone_Number__c = :phoneNumberConverted) ];
        //Examine the Phone_Lookup__c results for an exact match:
        if(searchResultsBasedOnDid1[0]!=null) {
            returnedPhoneLookups = searchResultsBasedOnDid1[0];
            if(returnedPhoneLookups.size() == 1) 
            {
                for(Phone_Lookup__c phl :returnedPhoneLookups) {
                    matchedAccountId = phl.Account__c;
                    matchedAccountName = phl.Account_Name__c;
                }
            }
        }
    } 
}