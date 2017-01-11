/**
 *      @author         Anudeep Gopagoni
 *      @date           November 1 2015
 *      @description    Controller class to the logacall Page. 
                        Supports all the below listed functionalities
                        1. Shows all the campaigns related to the account that the task is created on
                        2. Shows the the campaign members of a particular campaign along with their existing statuses
                        3. The campaign member status gets updated at the campaign level based on the changes made to the campaign member status while creating the task
 *      Modification Log: 
 *      ---------------------------------------------------------------------
 *      Developer                  Date                Description
 *      ---------------------------------------------------------------------
 *      Anudeep Gopagoni              Nov 1 2015           Initial Version
 */
public with sharing class LogACallControllerExtension {
        
        //local variables
        public Task task;
        public string taskId;
        public Set<Id> accContactIds = new Set<Id>();        
        public Set<Id> cmpgnContactIds = new Set<Id>();
        ApexPages.Standardcontroller controller;
        public List<Campaign> relatedCampaigns  {get;set;}
        public list<CampaignWrapper> CampaignWrapperList {get;set;}
        private Task currentTaskRecord;
        public Account currentAccountRecord;
        Set<Id> selectedIdCamp = new Set<Id>();
        public List<CampaignMember> campMem= new List<CampaignMember>();
        public List<CampaignMember> updateConMem= new List<CampaignMember>(); 
        
        //Controller
        public LogACallControllerExtension(ApexPages.StandardController controller) {
            this.task = (Task)controller.getRecord(); 
            this.task.Status = 'Completed';
            this.task.Subject = 'Call';
            User u = [Select Id From User Where id = :UserInfo.getUserId()];
            //Contact con = [Select Id From Contact Where accountId =:ApexPages.currentPage().getParameters().get('who_id')];
            //task.WhoId = con.Id;
            //fetch the related to field from the URL to display associated account on the Task
            task.WhatId = ApexPages.currentPage().getParameters().get('what_id');
            task.OwnerId = u.Id;    
            this.controller = controller;
            //fetch all the contacts present on the Account
            this.currentAccountRecord = [Select Id From Account Where Id = :ApexPages.currentPage().getParameters().get('what_id')];
            for(Account acc : [select id,Name,(select Id,Name from Contacts )  From Account where id = :ApexPages.currentPage().getParameters().get('what_id')])
            {
                for(Contact cnt: acc.contacts){
                    accContactIds.add(cnt.Id);
                }
            }
             //fetch all the campaigns related to the Account
            relatedCampaigns = new List<Campaign>([Select Name, status, StartDate, Type,
                                                    (Select Name, CampaignId, ContactId, Status, HasResponded, Contact.AccountId from CampaignMembers where Contact.AccountId  =:currentAccountRecord.Id
                                                    ) from Campaign where isActive = true]);
              CampaignWrapperList = new List<CampaignWrapper>(); 
                            
              for(Campaign cmp : relatedCampaigns)
                { 
                    for(CampaignMember cmpmem : cmp.CampaignMembers)
                      { 
                  CampaignWrapperList.add(new CampaignWrapper (cmp, cmpmem.Status, cmpmem.Name, cmpmem)); 
                  }
                } 
        }
            public List<SelectOption> regions
{
    get
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = CampaignMember.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

        for( Schema.PicklistEntry f : ple)
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        return options;
    }
}
   /*
    * @Class name : CampaignWrapper
    * @description: Wrapper class to capture checkbox selections and picklist selections
    */
        public class CampaignWrapper {
            //Fetch Campaign details
           public Campaign campgn {get; set;}
           public String CampStatus {get; set;} 
           public String campMemName {get; set;}
           public CampaignMember campgnMember {get; set;}
          //select checkbox
         public Boolean selectCheck  {get;set;}
         public CampaignWrapper(Campaign c, String CampStatus, String campMemName, CampaignMember campgnMember) {
                campgn = c;
                selectCheck= false;
                this.CampStatus = CampStatus; 
                this.campMemName = campMemName;
                this.campgnMember = campgnMember;
            }
        }
   /*
    * @Method name: save()
    * @description: This method stores the selected campaigns and updates the campaign member statuses based on the values choosen by the user
    */  
    public PageReference save() {
        String selectedcampId  = ''; 
        if(!CampaignWrapperList.isEmpty()) { 
            for(CampaignWrapper cm : CampaignWrapperList){ 
                if(cm.selectCheck == true) {
                           cm.campgnMember.Status = cm.CampStatus; 
                     updateConMem.add(cm.campgnMember);
                 }
               if(cm.selectCheck) { 
                selectedIdCamp.add(cm.campgnMember.Id); 
                   if(selectedcampId =='') 
                       selectedcampId = cm.campgnMember.Id;
                    else { 
                        selectedcampId = selectedcampId + ';'+cm.campgnMember.Id; 
                        System.debug('****selectedCampaigns*****' + selectedcampId + cm.campgnMember.Id);
                    } 
                   } 
                 }
                 update updateConMem;
                string selectcmpIds= selectedcampId ;
                this.task.selectedcampaign__c= selectcmpIds;
            } 
          return controller.save();
        }
       }