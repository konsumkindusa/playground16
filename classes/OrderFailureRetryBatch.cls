/*************************************************************************************************************/
/* This is the class for nightly Batch submission of Failed Orders which is not the part of R2.
/* One can leverage this class whenever this functionality comes into picture.
/* Remove Line# 18-20 and uncomment Line# 21-81 
/*************************************************************************************************************/
/* Class Name  : OrderFailureRetryBatch
 * Description   : Batch Apex Class to retry Order submission after Failure
 * Created By    : Raushan Anand
 * Created On    : 17-Nov-2015
 *
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                    Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Raushan Anand              17-Nov-2015               Initial version.
 *****************************************************************************************/
global class OrderFailureRetryBatch implements Database.Batchable<sObject>,Database.AllowsCallouts{
    global List<Order> start(Database.BatchableContext BC){return new List<Order>();}
    global void execute(Database.BatchableContext BC,List<Order> scope){}
    global void finish(Database.BatchableContext BC){}
    /*
    Account acct = new Account();
    List<Order> orderToUpdate = new List<Order>();
    public SalesProcessingRequest requestService = new SalesProcessingRequest();
    public SalesProcessingRequest.SalesOrderCreateRequest_Sync createRequest = new SalesProcessingRequest.SalesOrderCreateRequest_Sync();
    
    global List<Order> start(Database.BatchableContext BC){
        Date currentDate = Date.today();
        List<Order> failedOrder = [SELECT AccountId,BillingAddress,BillingCity,BillingCountry,BillingCountryCode,BillingLatitude,BillingLongitude,BillingPostalCode,
                                   BillingState,BillingStateCode,BillingStreet,Billing_Block__c,CompanyAuthorizedById,ContractId,Cost_Center__c,CreatedById,
                                   CreatedDate,CurrencyIsoCode,CustomerAuthorizedById,DeliveryBlock__c,Delivery_Block__c,Description,DiscountType__c,
                                   Discount_Amt__c,Discount_Percent__c,Discount__c,EffectiveDate,EndDate,Free_Goods_Agent__c,Free_Goods_Cost_Center__c,
                                   Free_Goods_Reason__c,Id,IDEXX_Region__c,IsDeleted,IsReductionOrder,LastModifiedById,LastModifiedDate,LastReferencedDate,
                                   LastViewedDate,LIMS_ID__c,OpportunityId,OrderNumber,OrderReferenceNumber,Order_Email__c,Order_Type__c,OriginalOrderId,
                                   OwnerId,Payment_Terms__c,Payment_Term__c,POC_Campaign__c,Points_Availed__c,Points_Redeemed__c,PoNumber,Pricebook2Id,
                                   Promo_Code__c,Quantity_of_Order_Tests__c,Reason__c,RecordTypeId,Sales_Division__c,Sales_Org__c,Save_Order__c,ShippingAddress
                                   ,ShippingCity,ShippingCountry,ShippingCountryCode,ShippingLatitude,ShippingLongitude,ShippingPostalCode,ShippingState,
                                   ShippingStateCode,ShippingStreet,Shipping_Charges__c,Shipping_Label_Text__c,Shipping_Method__c,Ship_Method__c,Status,
                                   StatusCode,Sum_of_Quantity__c,SystemModstamp,Task_Name__c,Tax_Charges__c,TotalAmount,Total__c,Type ,
                                   (SELECT AvailableQuantity,Batch__c,Campaign__c,CreatedById,CreatedDate,CurrencyIsoCode,Description,Discount_Reason__c,
                                    Discount_Type__c,Discount_Value__c,Discount__c,Free_Goods__c,Id,If_Backorded__c,IsDeleted,Kits_to_Test_Conversion_workflow__c,
                                    LastModifiedById,LastModifiedDate,ListPrice,Material_Number__c,Material_Text__c,Net_Price__c,Number_Confirmed__c,
                                    OrderId,OrderItemNumber,OriginalOrderItemId,Plant__c,PricebookEntryId,Pricing__c,Quantity,Quantity_of_Order_Tests__c,
                                    Quantity_Ordered__c,Shipping_Method__c,Ship_Date__c,Ship_Method__c,SystemModstamp,Tests_Per_Kit__c,UnitPrice,Units__c,
                                    Unit_Price_per_Test__c,UoM__c FROM OrderItems)
                                    FROM Order WHERE Status =: 'Processing' limit 2];//CreatedDate >= : currentDate AND 
        System.debug('###RA1-->'+ failedOrder.size());
        return failedOrder;

    }
    global void execute(Database.BatchableContext BC,List<Order> scope){
        List<OrderCreation.OliResult> oliList = new List<OrderCreation.OliResult>();
        
        WebServiceUtil webUtility = new WebServiceUtil();
        List<Order> ordList = new List<Order>(scope);
        if(!ordList.isEmpty()){
            Order ord = ordList.get(0);
            Account acct = [SELECT Id,Name, SAP_Customer_Number__c,CurrencyISOCOde FROM Account WHERE Id =: ord.AccountId];
            System.debug('####RA'+ acct);
            for(OrderItem orderI : ord.OrderItems){
                OrderCreation.OliResult oliR = new OrderCreation.OliResult();
                oliR.orderItem = orderI;
                oliR.quantityConfirmed = Integer.valueOf(orderI.Quantity);
                oliList.add(oliR);
            }
            SalesProcessingResponse.SalesOrderCreateResponse_Sync resultRes = webUtility.orderCreateCall(acct,ord,oliList);
            System.debug('####Result Response-->'+ resultRes);
            if(resultRes<>null){  
                if(resultRes.DocumentNumber <> null && resultRes.DocumentNumber <> '')
                    ord.OrderReferenceNumber = resultRes.DocumentNumber;
                	System.debug('#### ord.OrderReferenceNumber-->'+ ord.OrderReferenceNumber);
                	orderToUpdate.add(ord);
             }
        }
    }
    global void finish(Database.BatchableContext BC){
        if(!orderToUpdate.isEmpty()){
            UPDATE orderToUpdate;
            System.debug('### orderToUpdate-->'+ orderToUpdate);
        }
    }*/
}