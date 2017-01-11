/****************************************************************************
* Apex Class Name    : OrderCreationUtil
* Description        : Utility Class for the Order Create Wizard
                       
* Modification Log   : 
* ---------------------------------------------------------------------------
* Developer                   Date                   Description
* ---------------------------------------------------------------------------
* Raushan Anand             Feb 19 2016                 Created    
                                                   
****************************************************************************/
public with sharing class OrderCreationUtil {
    //Properties for Idexx Domain Value
    public static List<IDEXX_Domain_Values__c> domValList {
          get {
               if (domValList == null) {
                    domValList = [SELECT Name,Code__c,Description__c,Default_Cost_Center_For_Rep__c FROM IDEXX_Domain_Values__c WHERE Name!=:null and Active__c=:true ORDER BY Description__c ASC];
               }

               return domValList;
          }
          set;
     }
    //Properties for Credit Card Validation
    public static List<Credit_Card_Type_Number_Validation__mdt> ccValidationList {
          get {
               if (ccValidationList == null) {
                    ccValidationList = [SELECT Label, Minimum_Charecter__c,Maximum_Charecter__c,Starts_With__c FROM Credit_Card_Type_Number_Validation__mdt LIMIT 10];
               }
               return ccValidationList;
          }
          set;
     }
}