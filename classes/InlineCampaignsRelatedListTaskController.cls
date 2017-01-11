/* Class Name  : InlineCampaignsRelatedListTaskController 
 
 
* Modification Log:  
 * --------------------------------------------------------------------------------------------------------------------------------------
 * Developer              Date                   Modification ID       Description 
 * ---------------------------------------------------------------------------------------------------------------------------------------
     Pooja Wade          11/3/2015                  1001               inline VF page on task to show selected campaigns while logging a call
*/


public with sharing class InlineCampaignsRelatedListTaskController {
  
  //added an instance varaible for the standard controller
    //private ApexPages.StandardController controller     {get; set;}
    // campaign records
    public List<Campaign>          relatedCampaigns  {get;set;}
    public List<CampaignMember>    relatedCampMember {get;set;}
    public string taskId;
    // List to store the custom message
    public List<String>          noRecordsFound    {get;set;}
    // the current Account record
    private Task currentTaskRecord;
    // to fetch Campaign Member status on each Campaign for Account Primary Contact
    public Map<Id, CampaignMember> PrimaryContactStatus  {get;set;}
    //default constructor
    public InlineCampaignsRelatedListTaskController(ApexPages.StandardController controller){
      //Initializations
      //this.controller       = controller;    
      this.taskId= (Id)controller.getId();
      if(this.taskId!=null) { 
      currentTaskRecord = [SELECT Id,selectedcampaign__c from Task WHERE Id = :taskId LIMIT 1]; 
      }
      relatedCampaigns      = new List<Campaign>();
      relatedCampMember     = new List<CampaignMember>();
      PrimaryContactStatus = new Map<Id, CampaignMember>();
      //call the method to fetch the campaigns
      loadCampaigns();
    }
    /*
  * Method name     : loadCampaigns
  * Description     : pulls all the campaign records that contains campaign members (contact) related to the current Account
  * Return Type     : void
  * Input Parameter : nil
  * Modification ID : 1001
  */
    private void loadCampaigns(){
      
      //A relationship query to pull the campaign records based on a filter condition on the campaign member record
      if(taskId<>null)
      PrimaryContactStatus = new Map<Id, CampaignMember>();
      Set<Id> selectedIdCamp = new Set<Id>(); 
      if(currentTaskRecord.selectedcampaign__c <> null) { 
      List<String> splitCampgns = new List<String>();  
      for(String eachId :currentTaskRecord.selectedcampaign__c.split(';')) { 
         selectedIdcamp.add(Id.valueOf(eachId)); 
      } 
      
      
      } 
      if(!selectedIdcamp.isEmpty()) {
     // relatedCampaigns = [Select Name, Status, StartDate , Type from Campaign WHERE Id In : selectedIdcamp];
      relatedCampMember = [Select Id, CAmpaignId, Campaign.Name, Campaign.StartDate, Campaign.Type, Campaign.Status, Status , Contact.Name from CampaignMember where ID IN :selectedIdcamp];
      
      
      } 
      
      
      // MOD 1002 : storing Primary Contact's Campaign Member Status on each Campaign for this aCcount
   /*   for(Campaign camp: relatedCampaigns){
        PrimaryContactStatus.put(camp.Id, new CampaignMember(Status=''));
        for(CampaignMember cm : camp.CampaignMembers){
          if(currentAccountRecord.Primary_Contact__c == cm.ContactId)
            PrimaryContactStatus.put(camp.Id, cm);
        }  
      }*/
      // if there are no records, add the message to the list
      if(relatedCampMember.isEmpty())
        noRecordsFound = new List<String>{'No records found'};
    }
    

}