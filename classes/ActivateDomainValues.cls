public with sharing class ActivateDomainValues {
    List<IDEXX_Domain_Values__c> listDomainVal = new List<IDEXX_Domain_Values__c>();
    Set<IDEXX_Domain_Values__c> listDomainValToUpdate = new Set<IDEXX_Domain_Values__c>();
    List<IDEXX_Active_Domain_Values__mdt> activeDomainVal = new List<IDEXX_Active_Domain_Values__mdt>();
    Map<String, IDEXX_Active_Domain_Values__mdt> recordmap = new Map<String, IDEXX_Active_Domain_Values__mdt>();
    public ActivateDomainValues(){
        activeDomainVal = [SELECT Code__c, Description__c,Field_Name__c FROM IDEXX_Active_Domain_Values__mdt where Code__c != null AND Field_Name__c!=null AND Description__c!=null];
    }
    public void updateIdexxDomainValues(){
        if(activeDomainVal != null){ 
            for(IDEXX_Active_Domain_Values__mdt activedomVal : activeDomainVal){
                recordmap.put(activedomVal.Code__c+'^'+activedomVal.Description__c+'^'+activedomVal.Field_Name__c,activedomVal);
            }
            
            listDomainVal = [SELECT Id, Code__c, Description__c,Active__c, Name FROM IDEXX_Domain_Values__c WHERE Code__c !=: null];
            for(IDEXX_Domain_Values__c domVal : listDomainVal){
                if(recordmap.containsKey(domVal.Code__c+'^'+domVal.Description__c+'^'+domVal.Name)){
                    domVal.Active__c=true;       
                }
                else{
                    domVal.Active__c=false;
                }
            }
            /*for(IDEXX_Active_Domain_Values__mdt activedomVal : activeDomainVal){
                for(IDEXX_Domain_Values__c domVal : listDomainVal){
                    if(activedomVal.Code__c == domVal.Code__c && activedomVal.Description__c == domVal.Description__c && activedomVal.Field_Name__c == domVal.Name){
                        domVal.Active__c = true;
                        listDomainValToUpdate.add(domVal);
                    }
                    else{
                        domVal.Active__c = false;
                        listDomainValToUpdate.add(domVal);
                    }
                }
            }*/
            if(!listDomainVal.isEmpty()){
                System.Debug('###RA'+listDomainVal);
                UPDATE ( New List<IDEXX_Domain_Values__c> (listDomainVal));
            }
           /* 
            if(!listDomainValToUpdate.isEmpty()){
                System.Debug('###RA'+listDomainValToUpdate);
                //UPDATE ( New List<IDEXX_Domain_Values__c> (listDomainValToUpdate));
            }*/
        }
    }
    
}