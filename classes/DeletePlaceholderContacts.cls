/**************************************************************************************
 * Create By:   Deloitte Consulting LLP.
 * CreateDate:  15-Oct-2015
 * Description: This batch is designed to delete all Place holder Contacts that are marked to be deleted
 * 
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                 Created Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Vishal Negandhi          15-Oct-2015                   Initial version.
 **************************************************************************************/
global class DeletePlaceholderContacts implements Database.Batchable<sObject>, Schedulable{
	String Query; 

	global DeletePlaceholderContacts(){
		Query = 'Select Id FROM Contact WHERE Place_Holder_To_Be_Deleted__c = TRUE';
	}

    global Database.QueryLocator start(Database.BatchableContext BC){
    	return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope){
    	try{
    		delete scope;
    	}
    	catch(exception e){
    		// some exception
    	}	
    }
    
   	global void finish(Database.BatchableContext BC){
   	}
   	
   	global void execute (SchedulableContext SC){
         database.executeBatch(new DeletePlaceholderContacts());
    }
}