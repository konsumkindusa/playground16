public with sharing class UserTriggerHandler {
	Map<Id,User> userMap = new Map<Id,User>();
	public UserTriggerHandler() {
		userMap = new Map<Id,User>([SELECT Id,Name,Createdby.Name,Createdby.Profile.Name,Lastmodifiedby.Profile.Name,Lastmodifiedby.Name,Email,ProfileId,Profile.Name,UserRoleId From User LIMIT 1000]);
	}
	public void onBeforeUpdate(Map<Id,User> oldUserMap , Map<Id,User> newUserMap) {
		preventCentrifyUpdates(oldUserMap,newUserMap);		
	}
	private void preventCentrifyUpdates(Map<Id,User> oldUserMap , Map<Id,User> newUserMap) {		
		String centrifyProfileName = Label.CentrifyProfileName;		
		/*
		String dummyProfileName = Label.DummyProfileName;
		String etlUserName = Label.etlUserName;
		for(User newUser : newUserMap.values()) {
			String previousProfileName = userMap.get(newUser.Id).Profile.name;
			System.debug('previous profile name is:'+previousProfileName);
			if( etlUserName.equalsIgnoreCase(userMap.get(newUser.Id).Lastmodifiedby.Name) ) //&& previousProfileName != dummyProfileName 
			{
				if( newUser.ProfileId != oldUserMap.get(newUser.Id).ProfileId ) {
					newUser.ProfileId = oldUserMap.get(newUser.Id).ProfileId;					
				}	
				if( newUser.UserRoleId != oldUserMap.get(newUser.Id).UserRoleId && String.isNotBlank(String.valueOf(newUser.UserRoleId) ) ) {
					newUser.UserRoleId = oldUserMap.get(newUser.Id).UserRoleId;	
				}
			}
		}
		*/
		
		for(User newUser : newUserMap.values()) {
			String loggedInUserProfileName = userMap.get(Userinfo.getUserId()).Profile.name;
			String CreatedByProfileName = userMap.get(newUser.Id).CreatedBy.Profile.name;
			String previousProfileName = userMap.get(newUser.Id).Profile.name;
			if( loggedInUserProfileName == centrifyProfileName   )  //&& previousProfileName != dummyProfileName 
			{
				if( newUser.ProfileId != oldUserMap.get(newUser.Id).ProfileId ) {
					newUser.ProfileId = oldUserMap.get(newUser.Id).ProfileId;					
				}	
				if( newUser.UserRoleId != oldUserMap.get(newUser.Id).UserRoleId && String.isNotBlank(String.valueOf(newUser.UserRoleId) ) ) {
					newUser.UserRoleId = oldUserMap.get(newUser.Id).UserRoleId;	
				}
			}
		}
		

	}	
}