/**************************************************************************************
 * Create By:   Deloitte Consulting LLP.
 * CreateDate:  24-Sep-2015
 * Description: This Class does below processing
 *              1. This class is used to determine whether the trigger hander calls the corresponding handler method once or more than one time 
 *                 So we can determine recursive trigger calls and block them during "Update" Trigger event.
 *                 
 *  
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                 Created Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Hemanth Kumar V           24-Sep-2015                   Initial version.
 **************************************************************************************/
public class CheckRecursiveTrigger {
	private static Boolean isRun = true;
    public static Boolean runOnce(){	    
	    if(isRun){
	    	isRun=false;
	     	return true;
	    }
	    else {
	        return isRun;
	    }
    }
    
    private static Boolean isOrderDeleteRun = true;
    public static Boolean runOrderDeleteOnce(){
    	if(isOrderDeleteRun){
	    	isOrderDeleteRun=false;
	     	return true;
	    }
	    else {
	        return isOrderDeleteRun;
	    }
    }
    
    private static Boolean isOrderItemInsertRun = true;
    public static Boolean runOrderItemInsertOnce(){
    	if(isOrderItemInsertRun){
	    	isOrderItemInsertRun=false;
	     	return true;
	    }
	    else {
	        return isOrderItemInsertRun;
	    }
    }
    
    private static Boolean isOrderItemUpdateRun = true;
    public static Boolean runOrderItemUpdateOnce(){
    	if(isOrderItemUpdateRun){
	    	isOrderItemUpdateRun=false;
	     	return true;
	    }
	    else {
	        return isOrderItemUpdateRun;
	    }
    }
    
    private static Boolean isOrderItemDeleteRun = true;
    public static Boolean runOrderItemDeleteOnce(){
    	if(isOrderItemDeleteRun){
	    	isOrderItemDeleteRun=false;
	     	return true;
	    }
	    else {
	        return isOrderItemDeleteRun;
	    }
    }
}