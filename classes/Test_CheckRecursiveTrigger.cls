/**
*       @author Hemanth Vanapalli
*       @date   25/09/2015   
        @description    Test class for CheckRecursiveTrigger

        Function: This test class will test the trigger whether trigger is running once or multiple times.
        Modification Log:
        ------------------------------------------------------------------------------------
        Developer                       Date                Description
        ------------------------------------------------------------------------------------
        Hemanth Vanapalli               25/09/2015          Original Version
**/

@isTest(seeAllData=false)
private class Test_CheckRecursiveTrigger {
    static testMethod void recursiveUnitTest() {
        CheckRecursiveTrigger.runOnce();
        CheckRecursiveTrigger.runOnce();            
    }   
}