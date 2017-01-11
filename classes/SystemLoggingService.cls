/****************************************************************************
* Apex Class Name    : SystemLoggingService
* Description        : A generic utility class the
                       Integration request/response structures. 
                       contains utility methods to
*                      1.Incase of the callouts, contains method to log the request details under systemlog object under'Integration_Request' Record Type
*                      2.Also contains method to log the Response as 'Integration_Response' RecordType under SystemLogs
                       3.Contains method to log the Request/Response asynchronously
                       4.Also contains methods for logging exceptions thrown during apex execution to the Integration_Log__c object.
*                       Exceptions can be logged right away or stored in a list to be "flushed" after a rollback.
* Modification Log   :
* ---------------------------------------------------------------------------
* Developer                   Date                   Description
* ---------------------------------------------------------------------------
* Sirisha Kodi              Nov 16 2015             Created
****************************************************************************/

public with sharing class SystemLoggingService {
    
    /******************* STATIC CONSTANTS ********************************/
    public static final String  SEMICOLON                    = ';';
    public static final String  COLON                        = ':';
    public static final String  BLANK                        = '';
    public static final String  SPACE                        = ' ';
    public static final String  SINGLE_LINE_DELIM            = '\n';
    public static final String  DESC_LINE_DELIM              = SINGLE_LINE_DELIM + SINGLE_LINE_DELIM;
    public static final Integer TEXTFIELD_SIZE               = 255;
    public static final Integer LONGTEXTFIELD_SIZE           = 3000;
    public static final String  SystemLog_SobjectAPI         = 'System_Log__c';
    public static final String  SystemLog_ExceptionRT        = 'Apex_Exception';
    public static final String  SystemLog_RequestRT          = 'Integration_Request';
    public static final String  SystemLog_ResponseRT         = 'Integration_Response';
    public static final String  IntegrationLog_SobjectAPI    = 'Integration_Log__c';
    public static final String  IntegrationLog_ExceptionRT   = 'Exception_Log';
    public static final String  IntegrationLog_RequestRT     = 'Integration_Request';
    public static final String  IntegrationLog_ResponseRT    = 'Integration_Response';
    public static final String  GET_METHOD                   = 'GET';
    public static final String delimiter                     = 'delim';
    
    /******************* STATIC CONSTANTS ********************************/
    
    // Class constants
    public static final Id LOG_RECORD_TYPE_ID_REQUEST  = SystemLoggingService.returnRecordTypeId(IntegrationLog_SobjectAPI ,IntegrationLog_RequestRT);
    public static final Id LOG_RECORD_TYPE_ID_RESPONSE = SystemLoggingService.returnRecordTypeId(IntegrationLog_SobjectAPI ,IntegrationLog_ResponseRT);
    public static final Id LOG_RECORD_TYPE_ID_EXCEPTION = SystemLoggingService.returnRecordTypeId(IntegrationLog_SobjectAPI ,IntegrationLog_ExceptionRT);
    
    //List to store error logs when not logged immediately.
    private static List<Integration_Log__c> logsToFlush = new List<Integration_Log__c>();
    //Boolean used to determine to log immediately or not. During rollback scenarios set to true and call flushLogCache method after rollback.
    public static Boolean flushable = false;
    
     /*
     * @Method name  : getRecordTypeId
     * @Description  : Returns Id of the Record Type based on the Sobject and the developer Name
     * @Param        : Api Name of the Sobject, 
     * @Param        : RecordType Name
     */
    public static String concatenateFields(String recordType, String className, String methodName, String reqResBody, String intPoint){
        Id recordTypeId = recordType.equals(IntegrationLog_RequestRT)? LOG_RECORD_TYPE_ID_REQUEST : LOG_RECORD_TYPE_ID_RESPONSE;
        Boolean isRequestSent = recordType.equals(IntegrationLog_RequestRT)? false:true;
        
        return(recordTypeId+delimiter+className+delimiter+methodName+delimiter+isRequestSent+delimiter+reqResBody+delimiter+intPoint);
    }
    
    /*
     * @Method name  : getRecordTypeId
     * @Description  : Returns Id of the Record Type based on the Sobject and the developer Name
     * @Param        : Api Name of the Sobject, 
     * @Param        : RecordType Name
     */
    public static Id returnRecordTypeId(String sobjectName, String developerName){
    
        RecordType rt = [SELECT Id, DeveloperName, SobjectType FROM RecordType where SobjectType=: sobjectName and DeveloperName=: developerName];
        return((rt<>null)? rt.Id : null);
       
    }

    /*
     * @Method name  : logRequestResponseAsynchronous
     * @Description  : Returns an instance of the system Log record, This method is primarily used in all the integration Scenarios 
                      stores Request body or the response body based on the type of the request
     * @Return Type  : System Log record with all the fields initialized with the respective values
     * @Param        : Boolean Parameter that determines the request/response needs to be Logged Asynchrnously
     * @Param        : Boolean isRequestSent - determines if the Request is sent or not, 
     * @Param        : String Integration Point,
     * @Param        : String Request/Response Body, 
     * @Param        : String ClassName 
     * @Param        : String MethodName
       
     */
     @Future 
     public static void logRequestResponse(List<String> toBeInsertedLogs){
                                        
        List<Integration_Log__c> toBeInsertedIntegrationLogs = new List<Integration_Log__c>();
        List<String> reqResbody = new List<String>();
        List<Attachment> toBeInsertedAttachments = new List<Attachment>();
        for(String eachRecord : toBeInsertedLogs){
            List<String> eachFieldValue = eachRecord.split(delimiter);
            toBeInsertedIntegrationLogs.add(new Integration_Log__c(recordTypeId = Id.ValueOf(eachFieldValue[0]),
                                                                 Class_Name__c = eachFieldValue[1],
                                                                 Method_Name__c = eachFieldValue[2],
                                                                 Request_Sent__c = Boolean.valueOf(eachFieldValue[3]),
                                                                 Integration_Point__c = eachFieldValue[5],
                                                                 Response_Body__c = (Boolean.valueOf(eachFieldValue[3]))
                                                                                        ? (eachFieldValue[4].length()> 32768
                                                                                            ?BLANK:eachFieldValue[4])
                                                                                        :BLANK,
                                                                 Request_body__c = (!Boolean.valueOf(eachFieldValue[3]))
                                                                                        ?(eachFieldValue[4].length()> 32768
                                                                                            ?BLANK:eachFieldValue[4])
                                                                                        :BLANK));
        //If Request body in case of Request RT or the Response body in case of Response RT is blank?   
        if(eachFieldValue[4].length()>32768)
            reqResbody.add(eachFieldValue[4]);
       }
       try{
            if(!toBeInsertedIntegrationLogs.isEmpty()){
            	 if(ValidateInsertion())
                	insert toBeInsertedIntegrationLogs;
            }
            integer i = 0;
            for(Integration_Log__c insertedLogs : toBeInsertedIntegrationLogs){
                    if((insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_REQUEST) && insertedLogs.Request_body__c.equals(BLANK))
                        || (insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_RESPONSE) && insertedLogs.Response_Body__c.equals(BLANK)) ){
                            if(reqResbody.size()>0 && i < reqResbody.size()){
                                toBeInsertedAttachments.add(attachRequestBody(reqResbody[i], insertedLogs.Id));
                            }
                        i++;    
                    }
                }
            if(!toBeInsertedAttachments.isEmpty()){
            	 if(ValidateInsertion())
                	insert toBeInsertedAttachments;
            }
       }catch(DMLException  ex){
            //Error Logging
            throw ex;
        }
   }
   
    public static void logRequestResponse(List<String> toBeInsertedLogs, Boolean Syncronous){
    	if(Syncronous){
    		List<Integration_Log__c> toBeInsertedIntegrationLogs = new List<Integration_Log__c>();
	        List<String> reqResbody = new List<String>();
	        List<Attachment> toBeInsertedAttachments = new List<Attachment>();
	        for(String eachRecord : toBeInsertedLogs){
	            List<String> eachFieldValue = eachRecord.split(delimiter);
	            toBeInsertedIntegrationLogs.add(new Integration_Log__c(recordTypeId = Id.ValueOf(eachFieldValue[0]),
	                                                                 Class_Name__c = eachFieldValue[1],
	                                                                 Method_Name__c = eachFieldValue[2],
	                                                                 Request_Sent__c = Boolean.valueOf(eachFieldValue[3]),
	                                                                 Integration_Point__c = eachFieldValue[5],
	                                                                 Response_Body__c = (Boolean.valueOf(eachFieldValue[3]))
	                                                                                        ? (eachFieldValue[4].length()> 32768
	                                                                                            ?BLANK:eachFieldValue[4])
	                                                                                        :BLANK,
	                                                                 Request_body__c = (!Boolean.valueOf(eachFieldValue[3]))
	                                                                                        ?(eachFieldValue[4].length()> 32768
	                                                                                            ?BLANK:eachFieldValue[4])
	                                                                                        :BLANK));
	        //If Request body in case of Request RT or the Response body in case of Response RT is blank?   
	        if(eachFieldValue[4].length()>32768)
	            reqResbody.add(eachFieldValue[4]);
	       }
       try{
            if(!toBeInsertedIntegrationLogs.isEmpty()){
            	if(ValidateInsertion())
                	insert toBeInsertedIntegrationLogs;
            }
            integer i = 0;
            for(Integration_Log__c insertedLogs : toBeInsertedIntegrationLogs){
                    if((insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_REQUEST) && insertedLogs.Request_body__c.equals(BLANK))
                        || (insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_RESPONSE) && insertedLogs.Response_Body__c.equals(BLANK)) ){
                            if(reqResbody.size()>0 && i < reqResbody.size()){
                                toBeInsertedAttachments.add(attachRequestBody(reqResbody[i], insertedLogs.Id));
                            }
                        i++;    
                    }
                }
            if(!toBeInsertedAttachments.isEmpty()){
                if(ValidateInsertion())
                	insert toBeInsertedAttachments;
            }
       }catch(DMLException  ex){
            //Error Logging
            throw ex;
        }
      }                                   
   }
    
    public static Attachment attachRequestBody(String requestBody ,Id parentID)
        {
            Blob bodybinary =Blob.valueOf(requestBody);
            Attachment attach = new Attachment();
            attach.Body=bodyBinary;
            attach.ContentType='text/plain';
            attach.ParentId=parentID;
            //To ensure unique name
            attach.Name='RequestBody'+string.valueof(Datetime.now())+String.valueOf(Integer.valueof(Math.random()*1000000));
            return attach;
            
        }

    /*
     * Method used for logging a single exception that is thrown during apex execution.
     * @param System.Exception exceptionToLog
     * @return
    */
    public static void log(System.Exception exceptionToLog) {
    	if(!Test.isRunningTest())
        	log(new List<System.Exception>{exceptionToLog});
    }
    
    /*
     * Method used for logging a list of exceptions that are thrown during apex execution.
     * @param List<System.Exception> exceptionsToLog
     * @return
    */
    public static void log(List<System.Exception> exceptionsToLog) {
        List<Integration_Log__c> exLogsToSave = loggedExceptionFactory(exceptionsToLog);
        saveLog(exLogsToSave);
    }
    
    /*
     * Error record generation method; converts apex exceptions to a Integration_Log__c records.
     * @param List<System.Exception> exceptionsToLog
     * @return List<Integration_Log__c>
    */
    private static List<Integration_Log__c> loggedExceptionFactory(List<System.Exception> exceptionsToLog) {
        List<Integration_Log__c> logs = new List<Integration_Log__c>();
        for (System.Exception e : exceptionsToLog) {

                logs.add(new Integration_Log__c( recordTypeId = LOG_RECORD_TYPE_ID_EXCEPTION,
                                            Exception_Type__c= e.getTypeName().left(TEXTFIELD_SIZE),
                                            Detailed_Description__c = createExDescription(e), 
                                            Class_Name__c = extractClassName(e.getStackTraceString())
                                            ));
            }
        
        return logs;
    }
    
    /*
     * Using salesforce standard exception methods, generate a usable description of the exception.
     * @param System.Exception exceptionToLog
     * @return String
    */
    private static String createExDescription(System.Exception exceptionToLog) {
        String exDescription =  exceptionToLog.getMessage()+ DESC_LINE_DELIM + 
                                exceptionToLog.getTypeName() + 
                                DESC_LINE_DELIM + exceptionToLog.getStackTraceString();

        if (exceptionToLog.getCause() != null)
            exDescription += DESC_LINE_DELIM + createExDescription( exceptionToLog.getCause() );
        
        exDescription = exDescription.length()>LONGTEXTFIELD_SIZE? exDescription.left(LONGTEXTFIELD_SIZE):exDescription;
        return exDescription;
    }
    
    /*
     * Rip apart the Salesforce generated stack trace to find just the class name.
     * @param String stackTrace
     * @return String
    */
    private static String extractClassName(String stackTrace) {
        String className = '';
        className = stackTrace.substringBefore(':').left(TEXTFIELD_SIZE);
        return className;
    }
    
    /*
     * Perform and insert to logs if flushable set to false. If flushable true, just store Integration_Log__c records in list to "flush" later.
     * @param List<Integration_Log__c> logsToSave
     * @return
    */
    private static void saveLog(List<Integration_Log__c> logsToSave) {
        if (flushable)
            logsToFlush.addAll(logsToSave);
        else
            insert logsToSave;
    }

    /*
     * Method used during rollback scenarios to log all exceptions stored in class variable list at one time.
     * @param 
     * @return 
    */
    public static void flushLogCache() {
        if (!logsToFlush.isEmpty()) {
            insert logsToFlush;
            logsToFlush.clear();
        }
    }
    public static void logRequestResponseForBatch(List<String> toBeInsertedLogs){
                                        
        List<Integration_Log__c> toBeInsertedIntegrationLogs = new List<Integration_Log__c>();
        List<String> reqResbody = new List<String>();
        List<Attachment> toBeInsertedAttachments = new List<Attachment>();
        for(String eachRecord : toBeInsertedLogs){
            List<String> eachFieldValue = eachRecord.split(delimiter);
            toBeInsertedIntegrationLogs.add(new Integration_Log__c(recordTypeId = Id.ValueOf(eachFieldValue[0]),
                                                                 Class_Name__c = eachFieldValue[1],
                                                                 Method_Name__c = eachFieldValue[2],
                                                                 Request_Sent__c = Boolean.valueOf(eachFieldValue[3]),
                                                                 Integration_Point__c = eachFieldValue[5],
                                                                 Response_Body__c = (Boolean.valueOf(eachFieldValue[3]))
                                                                                        ? (eachFieldValue[4].length()> 32768
                                                                                            ?BLANK:eachFieldValue[4])
                                                                                        :BLANK,
                                                                 Request_body__c = (!Boolean.valueOf(eachFieldValue[3]))
                                                                                        ?(eachFieldValue[4].length()> 32768
                                                                                            ?BLANK:eachFieldValue[4])
                                                                                        :BLANK));
        //If Request body in case of Request RT or the Response body in case of Response RT is blank?   
        if(eachFieldValue[4].length()>32768)
            reqResbody.add(eachFieldValue[4]);
       }
       try{
            if(!toBeInsertedIntegrationLogs.isEmpty()){
                insert toBeInsertedIntegrationLogs;
            }
            integer i = 0;
            for(Integration_Log__c insertedLogs : toBeInsertedIntegrationLogs){
                    if((insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_REQUEST) && insertedLogs.Request_body__c.equals(BLANK))
                        || (insertedLogs.recordTypeId.equals(LOG_RECORD_TYPE_ID_RESPONSE) && insertedLogs.Response_Body__c.equals(BLANK)) ){
                            if(reqResbody.size()>0 && i < reqResbody.size()){
                                toBeInsertedAttachments.add(attachRequestBody(reqResbody[i], insertedLogs.Id));
                            }
                        i++;    
                    }
                }
            if(!toBeInsertedAttachments.isEmpty()){
                insert toBeInsertedAttachments;
            }
       }catch(DMLException  ex){
            //Error Logging
            throw ex;
        }
   }
   
   public static boolean ValidateInsertion(){
   		try{
   			Id profileId = userinfo.getProfileId();
   			IntegrationLogSwitch__c logSwitch = IntegrationLogSwitch__c.getInstance(profileId);
   			if(logSwitch <> null && logSwitch.LogFlag__c<>null)
   				return logSwitch.LogFlag__c;
   			else
   				return false;
   		}catch(Exception ex){
   			SystemLoggingService.log(ex);
   			return false;
   		}
   }
}