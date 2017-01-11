@isTest
public with sharing class Test_UserTrigger {
	@isTest
	private static void userTrigger1(){
		  Profile p = [SELECT Id FROM Profile WHERE Name='System Integration']; 
		  Profile SI = [SELECT Id FROM Profile WHERE Name='System Administrator'];
	      User u = new User(Alias = 'ISR-CAAG', Email='isr@test.com', 
	      EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
	      LocaleSidKey='en_US', ProfileId = p.Id, 
	      TimeZoneSidKey='America/Los_Angeles', UserName='isrcag@testorgggg.com');
	      insert u;
	      system.runAs(u){
	      //u.ProfileId = SI.Id;
	      update u;
	      }
	      
	      
	}
}