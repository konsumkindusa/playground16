/**
*       @author Vishal Negandhi
*       @date   16/10/2015   
        @description   Test Class with unit test scenarios to cover the PaginationController class
        Modification Log:
        ------------------------------------------------------------------------------------
        Developer                       Date                Description
        ------------------------------------------------------------------------------------
        Vishal Negandhi             15/10/2015          Original Version
**/
@isTest(seeAllData=false)
private class Test_PaginationController {
    static testMethod void Test_PaginationController1() {
    	PaginationController pc = new PaginationController();
    	pc.showPrevious();
    	pc.showNext();
    	pc.showFirst();
    	pc.showLast();
    	system.assert(pc.CurrentPage == 4, 'Current page number should be 4');
    }  
}