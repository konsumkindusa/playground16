trigger UserTrigger on User (before update) {
	UserTriggerHandler utHandler = new UserTriggerHandler();
	if(Trigger.isBefore) {
		if(CheckRecursiveTrigger.runOnce()){
			if(Trigger.isUpdate) {
				utHandler.onBeforeUpdate(Trigger.oldMap, Trigger.newMap);
			}	
		}		
	}
}