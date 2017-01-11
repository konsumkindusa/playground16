/**
*       @author     Hemanth Vanapalli
*       @date       13/10/2015   
        @description    This class is used to display the Activity history view as an inline VF page. 
        Function:       Class used to display the Activity History records VF page on the Account detail page.
        Modification Log:
        ------------------------------------------------------------------------------------
        Developer                       Date                Description
        ------------------------------------------------------------------------------------
        Hemanth Vanapalli         13/10/2015       Initial Version
        Anudeep Gopagoni          22/12/2015       Added ord getter setter to resolve issue stated in TkT-000244
        Anudeep Gopagoni          28/12/2015       Added Comments to the code
        Hemanth Vanapalli         19/01/2016       Modified code to address TKT-000206
        
**/

public with sharing class AccountActivityHistoryController {
    Id recordId;
    Account thisAccount;
    public   static List<DisplayWrapper>  acctWrapperListSortedByDate {get;set;}//List to fetch external object data   
    public static Map<String, sObject> acctMap{get; set;}
    
    static Order tmpOrder;
    static Case tmpCase;
    ActivityHistory tmpActivity;
    static String lstMdDateFormatted;
    static List<String> sortStrString;
    static List<String> sortdescList;
   
    public AccountActivityHistoryController(ApexPages.StandardController controller) {
       acctWrapperListSortedByDate = new List<DisplayWrapper>();
       acctMap = new Map<String, sObject>();
       sortStrString = new List<String>();
       sortdescList  = new List<String>();
       
        //this.controller = controller;
        recordId = controller.getId();
        thisAccount = (Account) controller.getRecord();
        
    }
    
    public void fetchAccountData(){ 
       acctWrapperListSortedByDate = new List<DisplayWrapper>();
       acctMap = new Map<String, sObject>();
       sortStrString = new List<String>();
       sortdescList  = new List<String>();
        if(thisAccount != null) {
            thisAccount= [SELECT Id,Name,
                            (SELECT Id,CreatedDate,LastModifiedDate,Owner.Name,OrderNumber, PoNumber  FROM Orders ORDER BY LastModifiedDate  limit 10),
                            (SELECT Id,CreatedDate,LastModifiedDate,Owner.Name,CaseNumber, Subject  FROM Cases ORDER BY LastModifiedDate  limit 10),                            
                            (SELECT Id,CreatedDate,LastModifiedDate,Owner.Name,OwnerId,Assignee_Role__c,AccountId,WhoId,IsTask,subject, Activity_Descriptions__c FROM ActivityHistories ORDER BY ActivityDate DESC , LastModifiedDate DESC  limit 10)                            
                          FROM Account WHERE Id =:recordId];
                          //(SELECT Id,CreatedDate,LastModifiedDate,Owner.Name,Name FROM Competitor_Products__r ORDER BY LastModifiedDate  limit 10),
              
              Integer counter = 0;
             //Initialize Wrapper instance 
                    for(Order ord: thisAccount.Orders){
                    DisplayWrapper disWrap = new DisplayWrapper();
                    disWrap.obType = 'Order';
                    disWrap.Id= ord.Id;
                    disWrap.Name= ord.Owner.Name;
                    disWrap.hyperlink= ord.OrderNumber;
                    disWrap.lstMdfDate= ord.LastModifiedDate;
                    lstMdDateFormatted= String.valueOf(ord.LastModifiedDate).subString(0,10);
                    disWrap.description= ord.PoNumber;
                    acctMap.put(lstMdDateFormatted+':'+counter+'Order', ord); 
                    
                    counter++;            
                }
                
                Integer counter1 = 0;
                for(Case cs: thisAccount.Cases){
                    DisplayWrapper disWrap = new DisplayWrapper();
                    disWrap.obType = 'Case';
                    disWrap.Id= cs.Id;
                    disWrap.Name= cs.Owner.Name;
                    disWrap.hyperlink= cs.CaseNumber;
                    disWrap.lstMdfDate= cs.LastModifiedDate;
                    lstMdDateFormatted= String.valueOf(cs.LastModifiedDate).subString(0,10);
                    disWrap.description= cs.Subject;
                    acctMap.put(lstMdDateFormatted+':'+counter1+'Case', cs); 
                    
                    counter1++;
                }
                
                Integer counter2 = 0;
                for(ActivityHistory ag: thisAccount.ActivityHistories){
                    DisplayWrapper disWrap = new DisplayWrapper();
                    disWrap.obType = 'Activity';
                    disWrap.Id= ag.Id;
                    disWrap.Name= ag.Owner.Name;
                    disWrap.hyperlink= ag.subject;
                    disWrap.lstMdfDate= ag.LastModifiedDate;
                    lstMdDateFormatted= String.valueOf(ag.LastModifiedDate).subString(0,10);
                    disWrap.description= ag.Activity_Descriptions__c ;
                    acctMap.put(lstMdDateFormatted+':'+counter2+'Activity', ag); 
                    
                    counter2++;
               }
                
                for(string str :acctMap.keySet()) {
                 sortStrString.add(str.subString(0,12));
                                  
                }
                sortStrString.sort();
                
                // Sort the list sortStrString in descending Order
                 
                for(Integer k = sortStrString.size()-1; k>=0;k--) {
                        sortdescList.add(sortStrString.get(k));                        
                    }
                
                Integer flag = 0;
                for(String st :sortdescList) {
                
                if( acctMap.containskey(st + 'Order')) {
                    //System.debug('Order Flag:'+flag);
                    tmpOrder = (Order) acctMap.get(st + 'Order');
                    DisplayWrapper disWrapSorted = new DisplayWrapper();
                    disWrapSorted.obType = 'Order';
                    disWrapSorted.Id= tmpOrder.Id;
                    disWrapSorted.Name= tmpOrder.Owner.Name;
                    disWrapSorted.hyperlink= tmpOrder.OrderNumber;
                    disWrapSorted.lstMdfDate= tmpOrder.LastModifiedDate;
                    disWrapSorted.description= tmpOrder.PoNumber;
                    if(!isAlreadyAdded(disWrapSorted.Id)){
                        acctWrapperListSortedByDate.add(disWrapSorted);
                    }
                    }
                    if( acctMap.containskey(st + 'Case')) {
                        
                    tmpCase = (Case) acctMap.get(st + 'Case');
                    DisplayWrapper disWrapSorted = new DisplayWrapper();
                    disWrapSorted.obType = 'Case';
                    disWrapSorted.Id= tmpCase.Id;
                    disWrapSorted.Name= tmpCase.Owner.Name;
                    disWrapSorted.hyperlink= tmpCase.CaseNumber;
                    disWrapSorted.lstMdfDate= tmpCase.LastModifiedDate;
                    disWrapSorted.description= tmpCase.subject;
                    if(!isAlreadyAdded(disWrapSorted.Id)){
                        acctWrapperListSortedByDate.add(disWrapSorted);
                    }
                    }
                    if( acctMap.containskey(st + 'Activity')) {
                        
                    tmpActivity = (ActivityHistory) acctMap.get(st + 'Activity');
                    DisplayWrapper disWrapSorted = new DisplayWrapper();
                    disWrapSorted.obType = 'Activity';
                    disWrapSorted.Id= tmpActivity.Id;
                    disWrapSorted.Name= tmpActivity.Owner.Name;
                    disWrapSorted.hyperlink= tmpActivity.subject;
                    disWrapSorted.lstMdfDate= tmpActivity.LastModifiedDate;
                    disWrapSorted.description= tmpActivity.Activity_Descriptions__c;
                    if(!isAlreadyAdded(disWrapSorted.Id)) {
                        acctWrapperListSortedByDate.add(disWrapSorted);
                    }
                    }
                    flag++;
                }
                
                
        }
        
    }
    public Boolean isAlreadyAdded(String objectId) {
        Boolean isAdded = false;
        for(DisplayWrapper disp: acctWrapperListSortedByDate) {
            if(disp.id == objectId) {
                return true;
            }
        }
        return false;
    }
    public class DisplayWrapper{ 
        
        public string Id{get;set;}
        public string obType {get;set;}
        public string Name{get;set;}
        public string hyperlink{get;set;}
        public string description{get;set;}
        public DateTime lstMdfDate{get;set;}
        
        public DisplayWrapper(){
            string Id =' ';
            string obType = ' ';
            string Name = ' ';
            string hyperlink = ' ';
            string description = ' ';
            DateTime lstMdfDate = null;
        }
    }
}