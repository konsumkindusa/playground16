/*
 * Request object for Contact Process.
 * 
 * This object servers as both a model object and XML marshalling intermediary.
 */ 
 public class ContactPersonProcessingRequest {
      public final static String NAMESPACE = 'http://idexxi.com/sapxi/pocbea/customer360';
      public final static String SAP_SERVICE_WRAPPER = 'ContactPersonReadRequest';
      
      
       public class ContactPersonQuery_Sync {
        public String CustomerID;
        public String[] ContactTypes;
        private String[] CustomerID_type_info = new String[]{'CustomerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] ContactTypes_type_info = new String[]{'ContactTypes','http://idexxi.com/sapxi/pocbea/customer360',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'CustomerID','ContactTypes'};
    }
    
    public class ContactPersonUpdate_Sync {
        public String PartnerID;
        public String CustomerID;
        public String ContactType;
        public String Department;
        public String Lastname;
        public String Firstname;
        public String Sex;
        public String Title;
        public String Language;
        public String LanguageISO;
        public ContactPersonProcessingResponse.CommunicationsFull Communications;
        private String[] PartnerID_type_info = new String[]{'PartnerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] CustomerID_type_info = new String[]{'CustomerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] ContactType_type_info = new String[]{'ContactType','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Department_type_info = new String[]{'Department','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Lastname_type_info = new String[]{'Lastname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Firstname_type_info = new String[]{'Firstname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Sex_type_info = new String[]{'Sex','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Title_type_info = new String[]{'Title','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Language_type_info = new String[]{'Language','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] LanguageISO_type_info = new String[]{'LanguageISO','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Communications_type_info = new String[]{'Communications','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'PartnerID','CustomerID','ContactType','Department','Lastname','Firstname','Sex','Title','Language','LanguageISO','Communications'};
    }
    
    public class ContactPersonCreate_Sync {
        public String CustomerID;
        public String ContactType;
        public String Department;
        public String Lastname;
        public String Firstname;
        public String Sex;
        public String Title;
        public String Language;
        public String LanguageISO;
        public ContactPersonProcessingResponse.CommunicationsLite Communications;
        private String[] CustomerID_type_info = new String[]{'CustomerID','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] ContactType_type_info = new String[]{'ContactType','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Department_type_info = new String[]{'Department','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Lastname_type_info = new String[]{'Lastname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Firstname_type_info = new String[]{'Firstname','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] Sex_type_info = new String[]{'Sex','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Title_type_info = new String[]{'Title','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Language_type_info = new String[]{'Language','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] LanguageISO_type_info = new String[]{'LanguageISO','http://idexxi.com/sapxi/pocbea/customer360',null,'0','1','false'};
        private String[] Communications_type_info = new String[]{'Communications','http://idexxi.com/sapxi/pocbea/customer360',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://idexxi.com/sapxi/pocbea/customer360','false','false'};
        private String[] field_order_type_info = new String[]{'CustomerID','ContactType','Department','Lastname','Firstname','Sex','Title','Language','LanguageISO','Communications'};
    }
    
    
 
}