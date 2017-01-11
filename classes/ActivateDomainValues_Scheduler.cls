global class ActivateDomainValues_Scheduler implements Schedulable{
    
    global void execute(SchedulableContext SC) {
        ActivateDomainValues domValUpdate = new ActivateDomainValues();
        domValUpdate.updateIdexxDomainValues();

    }
}