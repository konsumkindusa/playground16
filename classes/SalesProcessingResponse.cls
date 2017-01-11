/****************************************************************************
* Apex Class Name    : SalesProcessingResponse
* Description        : A generic utility class which has
                       response structures for the below listed web services 
                            1. SalesOrderCreate 
                            2. SalesOrderSimulate
                            3. SalesOrderChange
                            4. SalesOrderDelete
                       Also contains utility methods to parse and return the request structures. 
* Modification Log   :
* ---------------------------------------------------------------------------
* Developer                   Date                   Description
* ---------------------------------------------------------------------------
* Sirisha Kodi              Nov 25 2015             Created
****************************************************************************/
public with sharing class SalesProcessingResponse {
    
    
     public class SalesOrderSimulateResponse_Sync {
        public String               RewardItemsEligible;
        public Items_element[]      Items;
        public Conditions_element[] Conditions;
        public Return_element[]     Return_x;
        
        private String[] RewardItemsEligible_type_info = new String[]{'RewardItemsEligible','http://idexx.com/sappo/sales/salesforce',  null,'0', '1','false'};
        private String[] Items_type_info               = new String[]{'Items',              'http://idexx.com/sappo/sales/salesforce',  null,'0','-1','false'};
        private String[] Conditions_type_info          = new String[]{'Conditions',         'http://idexx.com/sappo/sales/salesforce',  null,'0','-1','false'};
        private String[] Return_x_type_info            = new String[]{'Return',             'http://idexx.com/sappo/sales/salesforce',  null,'0','-1','false'};
        private String[] apex_schema_type_info         = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info         = new String[]{'RewardItemsEligible','Items','Conditions','Return_x'};
    }
    
    
    public class SalesOrderSimulateResponse_SyncFuture extends System.WebServiceCalloutFuture {
      public SalesOrderSimulateResponse_Sync getValue() {
            SalesOrderSimulateResponse_Sync response = (SalesOrderSimulateResponse_Sync)System.WebServiceCallout.endInvoke(this);
            return response;
        }
    }
    
    public class SalesOrderCreateResponse_SyncFuture extends System.WebServiceCalloutFuture {
        public SalesOrderCreateResponse_Sync getValue() {
            SalesOrderCreateResponse_Sync response = (SalesOrderCreateResponse_Sync)System.WebServiceCallout.endInvoke(this);
            return response;
        }
    }
    /*
    * @Class name:  SalesOrderDeleteResponse_Sync 
    * @description: Wrapper class that represent the Items element in the request structure for the Order Delete Callout
    */
    
     public class SalesOrderDeleteResponse_Sync {
        public Return_element[] Return_x;
        private String[] Return_x_type_info = new String[]{'Return','http://idexx.com/sappo/sales/salesforce',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info = new String[]{'Return_x'};
    }
    
    public class SalesOrderCreateResponse_Sync {
        public String DocumentNumber;
        public Items_element[] Items;
        public Return_element[] Return_x;
        private String[] DocumentNumber_type_info = new String[]{'DocumentNumber','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] Items_type_info = new String[]{'Items','http://idexx.com/sappo/sales/salesforce',null,'0','-1','false'};
        private String[] Return_x_type_info = new String[]{'Return','http://idexx.com/sappo/sales/salesforce',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info = new String[]{'DocumentNumber','Items','Return_x'};
    }
    
    public class Items_element {
        public String ExternalItemNumber;
        public String ItemNumber;
        public String Material;
        public String Batch;
        public String Plant;
        public String StorageLocation;
        public String RequestedQuantity;
        public String ItemCategory;
        public String RequestedDeliveryDate;
        public String ConditionType1;
        public String MaterialGroup3;
        public String MaterialGroup4;
        public String MaterialGroup5;
        public String ConditionValue1;
        public String ConditionCurrency1;
        public String Incoterms;
        public String ReferenceDocument;
        public String ReferenceDocumentItem;
        public String ReferenceDocumentCategory;
        public String ConditionType2;
        public String ConditionValue2;
        public String ConditionCurrency2;
        public String ConditionType3;
        public String ConditionValue3;
        public String ConditionCurrency3;
        public String ConditionType4;
        public String ConditionValue4;
        public String ConditionCurrency4;
        public String ShippingPoint;
        public String SpeedCode;
        public String ShortText;
        public String CurrencyT;
        public String UoM;
        public String DeliveryDate;
        public String ConfirmedQuantity;
        public String HigherLevelItem;
        public String MaterialGroup;
        public String Subtotal1;
        public String Subtotal2;
        public String Subtotal3;
        public String Subtotal4;
        public String Subtotal5;
        public String Subtotal6;
        public String BatchedItem;
        public String BatchExpirationDate;
        public String ShortDatedBatch;
        public String MaterialSalesText;
        
        private String[] ExternalItemNumber_type_info = new String[]{'ExternalItemNumber','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ItemNumber_type_info = new String[]{'ItemNumber','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        
        private String[] Material_type_info = new String[]{'Material','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] Batch_type_info = new String[]{'Batch','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] Plant_type_info = new String[]{'Plant','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] StorageLocation_type_info = new String[]{'StorageLocation','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] RequestedQuantity_type_info = new String[]{'RequestedQuantity','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ItemCategory_type_info = new String[]{'ItemCategory','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] RequestedDeliveryDate_type_info = new String[]{'RequestedDeliveryDate','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionType1_type_info = new String[]{'ConditionType1','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] MaterialGroup3_type_info = new String[]{'MaterialGroup3','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] MaterialGroup4_type_info = new String[]{'MaterialGroup4','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] MaterialGroup5_type_info = new String[]{'MaterialGroup5','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionValue1_type_info = new String[]{'ConditionValue1','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionCurrency1_type_info = new String[]{'ConditionCurrency1','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] Incoterms_type_info = new String[]{'Incoterms','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ReferenceDocument_type_info = new String[]{'ReferenceDocument','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ReferenceDocumentItem_type_info = new String[]{'ReferenceDocumentItem','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ReferenceDocumentCategory_type_info = new String[]{'ReferenceDocumentCategory','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionType2_type_info = new String[]{'ConditionType2','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionValue2_type_info = new String[]{'ConditionValue2','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionCurrency2_type_info = new String[]{'ConditionCurrency2','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionType3_type_info = new String[]{'ConditionType3','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionValue3_type_info = new String[]{'ConditionValue3','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionCurrency3_type_info = new String[]{'ConditionCurrency3','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionType4_type_info = new String[]{'ConditionType4','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionValue4_type_info = new String[]{'ConditionValue4','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ConditionCurrency4_type_info = new String[]{'ConditionCurrency4','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] ShippingPoint_type_info = new String[]{'ShippingPoint','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        private String[] SpeedCode_type_info = new String[]{'SpeedCode','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] ShortText_type_info = new String[]{'ShortText','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] CurrencyT_type_info = new String[]{'Currency','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] UoM_type_info = new String[]{'UoM','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] DeliveryDate_type_info = new String[]{'DeliveryDate','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] ConfirmedQuantity_type_info = new String[]{'ConfirmedQuantity','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] HigherLevelItem_type_info = new String[]{'HigherLevelItem','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] MaterialGroup_type_info = new String[]{'MaterialGroup','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal1_type_info = new String[]{'Subtotal1','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal2_type_info = new String[]{'Subtotal2','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal3_type_info = new String[]{'Subtotal3','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal4_type_info = new String[]{'Subtotal4','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal5_type_info = new String[]{'Subtotal5','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] Subtotal6_type_info = new String[]{'Subtotal6','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] BatchedItem_type_info = new String[]{'BatchedItem','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] BatchExpirationDate_type_info = new String[]{'BatchExpirationDate','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] ShortDatedBatch_type_info = new String[]{'ShortDatedBatch','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
      private String[] MaterialSalesText_type_info = new String[]{'MaterialSalesText','http://idexx.com/sappo/sales/salesforce',null,'1','1','false'};
        
        private String[] apex_schema_type_info = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info = new String[]{'ExternalItemNumber','ItemNumber','Material','Batch', 'Plant','StorageLocation','RequestedQuantity',
            'ItemCategory','RequestedDeliveryDate','ConditionType1','MaterialGroup3','MaterialGroup4','MaterialGroup5','ConditionValue1', 'ConditionCurrency1', 'Incoterms', 
            'ReferenceDocument', 'ReferenceDocumentItem', 'ReferenceDocumentCategory', 'ConditionType2', 'ConditionValue2', 'ConditionCurrency2', 'ConditionType3', 'ConditionValue3', 'ConditionCurrency3', 'ConditionType4', 'ConditionValue4', 'ConditionCurrency4', 'ShippingPoint',
            'SpeedCode', 'ShortText', 'UoM', 'DeliveryDate', 'ConfirmedQuantity', 'HigherLevelItem', 'MaterialGroup', 'Subtotal1', 'Subtotal2', 'Subtotal3', 'Subtotal4', 'Subtotal5', 'Subtotal6', 'BatchedItem', 'BatchExpirationDate', 'ShortDatedBatch', 'MaterialSalesText','CurrencyT'};
    }
    
     public class Conditions_element {
        public String ItemNumber;
        public String ConditionType;
        public String ConditionValue;
        public String Currency_x;
        public String Description;
        public String ConditionClass;
        private String[] ItemNumber_type_info = new String[]{'ItemNumber','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] ConditionType_type_info = new String[]{'ConditionType','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] ConditionValue_type_info = new String[]{'ConditionValue','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] Currency_x_type_info = new String[]{'Currency','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] Description_type_info = new String[]{'Description','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] ConditionClass_type_info = new String[]{'ConditionClass','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info = new String[]{'ItemNumber','ConditionType','ConditionValue','Currency_x', 'Description','ConditionClass'};
    }


    public class Return_element {
        public String MessageType{get;set;}
        public String MessageID;
        public String MessageNumber;
        public String Message{get;set;}
        private String[] MessageType_type_info = new String[]{'MessageType','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] MessageID_type_info = new String[]{'MessageID','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] MessageNumber_type_info = new String[]{'MessageNumber','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] Message_type_info = new String[]{'Message','http://idexx.com/sappo/sales/salesforce',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexx.com/sappo/sales/salesforce','false','false'};
        private String[] field_order_type_info = new String[]{'MessageType','MessageID','MessageNumber','Message'};
    }
}