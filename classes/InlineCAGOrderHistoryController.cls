public with sharing class InlineCAGOrderHistoryController {

 public List<CAG_Order_History__c>  CAGOrders{ get;set; } 
 public String displayLength{get;set;}
 
private ApexPages.StandardController                    controller;
    private Account currentAccountRecord;
      public String                      errorMsg     { get;set; }
        public   static final String              TECHNICAL_DETAILS = 'Technical Details : ';
    public InlineCAGOrderHistoryController(ApexPages.StandardController controller) {
    this.controller = controller;  
    this.currentAccountRecord = [Select Id from Account where id=:controller.getId()];  
    
        if(System.currentPageReference().getParameters().get('dropDown')!= null) {        	
        	displayLength = 'true';        	
        }
        else { 
        	displayLength = 'false';
        }  	
        if(currentAccountRecord<> null){
                CAGOrders = [SELECT id, Name,Order_Date__c, Order_Details__c from CAG_Order_History__c where Account__c= :currentAccountRecord.id limit 1000];
          }
             
          else
            errorMsg = TECHNICAL_DETAILS;
          }
          


}