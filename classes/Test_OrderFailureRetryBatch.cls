/*************************************************************************************************************/
/* This is the test class for nightly Batch submission of Failed Orders which is not the part of R2.
/* One can leverage this test class whenever this functionality comes into picture.
/* Uncomment line# 19-68 and remove line# 69-73
/*************************************************************************************************************/
/* Class Name  : OrderFailureRetryBatch
 * Description   : Test Class to test retry Order submission after Failure
 * Created By    : Raushan Anand
 * Created On    : 15-Jan-2015
 *
 *  Modification Log :
 *  --------------------------------------------------------------------------------------
 *  * Developer                    Date                    Description
 *  * ------------------------------------------------------------------------------------                 
 *  * Raushan Anand              15-Jan-2015               Initial version.
 *****************************************************************************************/
@isTest
public class Test_OrderFailureRetryBatch {
   /* public static testmethod void testBatch1(){
        //Account 
        Account thisAccount = new Account();
        thisAccount = CreateTestClassData.createAccountTypeWithCurrency(Label.RT_Customer,Label.USD);
        
        //Insert Products 
        Product2 testProduct = new Product2(Name='SNAP PRO STARTER KIT', Family='test', SAP_MATERIAL_NUMBER__c = String.valueOf(Math.random()).subString(15));
        insert testProduct;
        
        Pricebook2 priceBook = CreateTestClassData.reusablePricebook2('IDEXX Standard Price Book');
        insert priceBook;
        
        Id pricebookId = Test.getStandardPricebookId();
        //Standard price book Entry
        PricebookEntry stdpriceBookEntry = CreateTestClassData.reusablePriceBookEntry(testProduct.Id, pricebookId,1000);
        stdpriceBookEntry.UseStandardPrice = false;
        insert stdpriceBookEntry;
        list <PricebookEntry> lststdpriceBookEntry = new list <PricebookEntry> (); 
        lststdpriceBookEntry.add(new PricebookEntry(Product2Id = testProduct.Id, Pricebook2Id = priceBook.Id, UnitPrice = 1000,IsActive = true,PriceBook_SAPMatNr__c=String.valueOf(Math.random()).subString(10)));
        insert lststdpriceBookEntry;
        //Set Shipping and Billing Address to the account
        thisAccount = CreateTestClassData.setBillingAddress(thisAccount);
        thisAccount = CreateTestClassData.setShippingAddress(thisAccount);
        update thisAccount;
        Order Ord = new Order();
        Ord.AccountId = thisAccount.id;
        Ord.Status = 'Processing';
        Ord.CurrencyIsoCode = 'USD';
        Ord.EffectiveDate = Date.Today();
        Ord.Pricebook2Id = priceBook.Id;
        insert Ord;
        list <OrderItem> LstOrderProducts = new list <OrderItem> ();
        for (Integer i = 1; i <= 15; i++) {
            OrderItem tempOrderProd = new OrderItem();
            tempOrderProd.OrderId = Ord.Id;
            tempOrderProd.UnitPrice = 1000;
            tempOrderProd.Shipping_Method__c = 'Overnight';
            tempOrderProd.Discount_Reason__c = '';
            tempOrderProd.Quantity = 2;
            tempOrderProd.PricebookEntryId = lststdpriceBookEntry[0].Id;
            LstOrderProducts.add(tempOrderProd);
        }
        insert LstOrderProducts;
        String sampleResponse = 'SalesOrderCreateResponse_Sync:[DocumentNumber=1439013743, DocumentNumber_type_info=(DocumentNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Items=(Items_element:[Batch=null, BatchExpirationDate=null, BatchExpirationDate_type_info=(BatchExpirationDate, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Batch_type_info=(Batch, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), BatchedItem=null, BatchedItem_type_info=(BatchedItem, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionCurrency1=null, ConditionCurrency1_type_info=(ConditionCurrency1, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionCurrency2=null, ConditionCurrency2_type_info=(ConditionCurrency2, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionCurrency3=null, ConditionCurrency3_type_info=(ConditionCurrency3, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionCurrency4=null, ConditionCurrency4_type_info=(ConditionCurrency4, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionType1=null, ConditionType1_type_info=(ConditionType1, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionType2=null, ConditionType2_type_info=(ConditionType2, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionType3=null, ConditionType3_type_info=(ConditionType3, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionType4=null, ConditionType4_type_info=(ConditionType4, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionValue1=null, ConditionValue1_type_info=(ConditionValue1, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionValue2=null, ConditionValue2_type_info=(ConditionValue2, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionValue3=null, ConditionValue3_type_info=(ConditionValue3, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConditionValue4=null, ConditionValue4_type_info=(ConditionValue4, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ConfirmedQuantity=1.0, ConfirmedQuantity_type_info=(ConfirmedQuantity, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), CurrencyT=null, CurrencyT_type_info=(Currency, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), DeliveryDate=null, DeliveryDate_type_info=(DeliveryDate, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ExternalItemNumber=null, ExternalItemNumber_type_info=(ExternalItemNumber, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), HigherLevelItem=null, HigherLevelItem_type_info=(HigherLevelItem, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Incoterms=null, Incoterms_type_info=(Incoterms, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ItemCategory=null, ItemCategory_type_info=(ItemCategory, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ItemNumber=000010, ItemNumber_type_info=(ItemNumber, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Material=null, MaterialGroup3=null, MaterialGroup3_type_info=(MaterialGroup3, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), MaterialGroup4=null, MaterialGroup4_type_info=(MaterialGroup4, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), MaterialGroup5=null, MaterialGroup5_type_info=(MaterialGroup5, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), MaterialGroup=null, MaterialGroup_type_info=(MaterialGroup, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), MaterialSalesText=null, MaterialSalesText_type_info=(MaterialSalesText, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Material_type_info=(Material, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Plant=null, Plant_type_info=(Plant, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ReferenceDocument=null, ReferenceDocumentCategory=null, ReferenceDocumentCategory_type_info=(ReferenceDocumentCategory, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ReferenceDocumentItem=null, ReferenceDocumentItem_type_info=(ReferenceDocumentItem, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ReferenceDocument_type_info=(ReferenceDocument, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), RequestedDeliveryDate=null, RequestedDeliveryDate_type_info=(RequestedDeliveryDate, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), RequestedQuantity=1.0, RequestedQuantity_type_info=(RequestedQuantity, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ShippingPoint=null, ShippingPoint_type_info=(ShippingPoint, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ShortDatedBatch=null, ShortDatedBatch_type_info=(ShortDatedBatch, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), ShortText=null, ShortText_type_info=(ShortText, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), SpeedCode=null, SpeedCode_type_info=(SpeedCode, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), StorageLocation=null, StorageLocation_type_info=(StorageLocation, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal1=null, Subtotal1_type_info=(Subtotal1, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal2=null, Subtotal2_type_info=(Subtotal2, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal3=null, Subtotal3_type_info=(Subtotal3, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal4=null, Subtotal4_type_info=(Subtotal4, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal5=null, Subtotal5_type_info=(Subtotal5, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), Subtotal6=null, Subtotal6_type_info=(Subtotal6, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), UoM=null, UoM_type_info=(UoM, http://idexx.com/sappo/sales/salesforce, null, 1, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(ExternalItemNumber, ItemNumber, Material, Batch, Plant, StorageLocation, RequestedQuantity, ItemCategory, RequestedDeliveryDate, ConditionType1, ...)]), Items_type_info=(Items, http://idexx.com/sappo/sales/salesforce, null, 0, -1, false), Return_x=(Return_element:[Message=SALES_HEADER_IN has been processed successfully, MessageID=V4, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=233, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=S, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)], Return_element:[Message=SALES_ITEM_IN has been processed successfully, MessageID=V4, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=233, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=S, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)], Return_element:[Message=SALES_CONDITIONS_IN has been processed successfully, MessageID=V4, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=233, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=S, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)], Return_element:[Message=Batch 3098 for 98-20590-00 not allowed for sale in CA, MessageID=VL, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=992, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=W, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)], Return_element:[Message=Batch 3098 for 98-20590-00 not allowed for sale in CA, MessageID=VL, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=992, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=W, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)], Return_element:[Message=Standard Order 1439013743 has been saved, MessageID=V1, MessageID_type_info=(MessageID, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageNumber=311, MessageNumber_type_info=(MessageNumber, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), MessageType=S, MessageType_type_info=(MessageType, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), Message_type_info=(Message, http://idexx.com/sappo/sales/salesforce, null, 0, 1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(MessageType, MessageID, MessageNumber, Message)]), Return_x_type_info=(Return, http://idexx.com/sappo/sales/salesforce, null, 0, -1, false), apex_schema_type_info=(http://idexx.com/sappo/sales/salesforce, false, false), field_order_type_info=(DocumentNumber, Items, Return_x)]';
        Test_ReusableMockResponse fakeResponse = new Test_ReusableMockResponse(200,'SUCCESS',sampleResponse, new map<String,String>{'Content-Type'=>'application/json'});
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
            Database.executeBatch(new OrderFailureRetryBatch(),1);   
        Test.stopTest();
    }*/
    public static testmethod void testBatch1(){
    	Test.startTest();
            Database.executeBatch(new OrderFailureRetryBatch(),1);   
        Test.stopTest();
    }
}