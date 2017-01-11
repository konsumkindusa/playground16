/*
 * Response object for Contact Process.
 * 
 * This object servers as both a model object and XML marshalling intermediary.
 */ 
 public class ContactPersonProcessingResponse {
     public final static String NAMESPACE = 'http://idexxi.com/sapxi/pocbea/customer360';
     public final static String SAP_SERVICE_WRAPPER = 'ContactPersonReadResponse';
     
     public class ContactPersonsQuery_Sync {
        public ContactPerson[] ContactPerson {get;set;}
        public Messages[] Messages;
        private String[] ContactPerson_type_info = new String[]{'ContactPerson','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] Messages_type_info = new String[]{'Messages','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'ContactPerson','Messages'};
    }
    
    public class ContactPerson {
        public String PartnerID;
        public String CustomerID;
        public String ContactType;
        public String Department {get;set;}
        public String Lastname {get;set;}
        public String Firstname {get;set;}
        public String Sex;
        public String Title;
        public String Language;
        public String LanguageISO;
        public String AddressID;
        public String PersonID;
        public CommunicationsFull Communications {get;set;}
        private String[] PartnerID_type_info = new String[]{'PartnerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] CustomerID_type_info = new String[]{'CustomerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] ContactType_type_info = new String[]{'ContactType','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Department_type_info = new String[]{'Department','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Lastname_type_info = new String[]{'Lastname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Firstname_type_info = new String[]{'Firstname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Sex_type_info = new String[]{'Sex','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Title_type_info = new String[]{'Title','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Language_type_info = new String[]{'Language','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] LanguageISO_type_info = new String[]{'LanguageISO','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] AddressID_type_info = new String[]{'AddressID','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] PersonID_type_info = new String[]{'PersonID','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Communications_type_info = new String[]{'Communications','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'PartnerID','CustomerID','ContactType','Department','Lastname','Firstname','Sex','Title','Language','LanguageISO','AddressID','PersonID','Communications'};
 }
 
 public class Messages {
        public String MessageType;
        public String MessageID;
        public String MessageNumber;
        public String Message;
        private String[] MessageType_type_info = new String[]{'MessageType','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] MessageID_type_info = new String[]{'MessageID','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] MessageNumber_type_info = new String[]{'MessageNumber','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Message_type_info = new String[]{'Message','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'MessageType','MessageID','MessageNumber','Message'};
    }
    
    public class CommunicationsFull {
        public Telephones_element Telephones;
        public Telephone_element Telephone;
        public Faxes_element Faxes;
        public Emails_element Emails {get;set;}
        private String[] Telephones_type_info = new String[]{'Telephones','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Telephone_type_info = new String[]{'Telephone','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Faxes_type_info = new String[]{'Faxes','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Emails_type_info = new String[]{'Emails','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Telephones','Faxes','Emails'};
    }
    
    public class Telephones_element {
        public Default_element Default_x {get;set;}
        public Additional_element[] Additional;
        private String[] Default_x_type_info = new String[]{'Default','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Additional_type_info = new String[]{'Additional','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Default_x','Additional'};
    }
    
    public class Telephone_element {
        public Default_element Default_x {get;set;}
        public Additional_element[] Additional;
        private String[] Default_x_type_info = new String[]{'Default','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Additional_type_info = new String[]{'Additional','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Default_x','Additional'};
    }
    
    
    
    public class Faxes_element {
        public Default_element Default_x;
        public Additional_element[] Additional;
        private String[] Default_x_type_info = new String[]{'Default','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Additional_type_info = new String[]{'Additional','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Default_x','Additional'};
    }
    
    public class Emails_element {
        public Default_element Default_x {get;set;}
        public Additional_element[] Additional;
        private String[] Default_x_type_info = new String[]{'Default','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Additional_type_info = new String[]{'Additional','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Default_x','Additional'};
    }
    
    public class Default_element {
        public String DoNotUse;
        public String Email {get;set;}
        public String Telephone;
        public String Fax;
        private String[] Fax_type_info = new String[]{'Fax','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] DoNotUse_type_info = new String[]{'DoNotUse','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Email_type_info = new String[]{'Email','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Telephone_type_info = new String[]{'Telephone','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'DoNotUse','Email'};
        
    }
    
    public class CommunicationsLite {
        public ContactPersonProcessingResponse.Telephones_element Telephones;
        public ContactPersonProcessingResponse.Faxes_element Faxes;
        public ContactPersonProcessingResponse.Emails_element Emails;
        private String[] Telephones_type_info = new String[]{'Telephones','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Faxes_type_info = new String[]{'Faxes','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Emails_type_info = new String[]{'Emails','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'Telephones','Faxes','Emails'};
    }
    
    public class MessagesReturn {
        public Boolean IsError;
        public ContactPersonProcessingResponse.Messages[] Messages;
        private String[] IsError_type_info = new String[]{'IsError','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Messages_type_info = new String[]{'Messages','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'IsError','Messages'};
    }
    
    public class Additional_element {
        public String DoNotUse;
        public String Email;
        public String Telephone;
        private String[] DoNotUse_type_info = new String[]{'DoNotUse','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Email_type_info = new String[]{'Email','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Telephone_type_info = new String[]{'Telephone','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'DoNotUse','Email'};
    }
 }