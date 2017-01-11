public class PointsToLeaseService {
    //NamedCredential representing SAP HANA endpoint
    private final String serviceEndPoint = 'callout:PointsToLease';    
    
    //Path for points to lease service on SAP HANA.
    //SAP_ID in this string resplaced at runtime 
    private final String path = '/POINT_TO_LEASEParameters(SAP_ID)/Results?$format=json';
    
    
    /**
     * Class to represent Points To Lease data.
     **/
    public class PointsToLease {
        public String soldTo;
        public String shipTo;
        public String contract;
        public String salesOrg;
        public String disChnl;
        public String division;
        public String item;
        public String points;
        
        //CURRENCY is a reserved word and cannot be used.  Need to replace that with something
        //else so that it can be properly parsed to the object.
        public String curr;
        
        public PointsToLease(String sold, String ship, String con, String org, String channel, String div, String it, String p, String cur) {
            soldTo = sold;
            shipTo = ship;
            contract = con;
            salesOrg = org;
            disChnl = channel;
            division = div;
            item = it;
            points = p;
            curr = cur;
        }
        
    }
    
    /**
     * Method call to make the points to Lease call to SAP HANA via a NamedCredential.
     * 
     * Parameters: Customer Id as String
     * Return: List<PointsToLease>
     * 
     **/ 
    public List<PointsToLease> getPointsToLeaseForCustomer(String customerId) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        
        //Substitute customer id into service call path
        String endpoint = serviceEndPoint + path;
        endpoint = endpoint.replace('SAP_ID', customerId);
        
        req.setEndpoint(endpoint);        
        req.setMethod('GET');
        req.setHeader('sessionId', UserInfo.getSessionId());
        
        HttpResponse res = h.send(req);
        system.debug('>>>>>>>>>>>>   ' + res.getBody());
               
        //parse results into list of PointsToLease
        List<PointsToLease> l = parsePointsToLease(res.getBody());        
        
        return l;
    }
    

    /**
     * Helper method to process JSON response into List<PointsToLease>.
     * 
     * Parameters: JSON (as string)
     * Return: List<PointsToLease>
     * 
     **/
    private List<PointsToLease> parsePointsToLease(String body) {       
        List<PointsToLease> l = new List<PointsToLease>();        
        
        //CURRENCY is a reserved word and cannot be used.  Need to replace that with something
        //else so that it can be properly parsed to the object.
        //
        //TODO: Move things like this to a helper.
        body = body.replace('CURRENCY', 'curr');
        
        JSONParser parser = JSON.createParser(body);
        
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.START_ARRAY)) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        PointsToLease p = (PointsToLease)parser.readValueAs(PointsToLease.class);
                        
                        l.add(p);
                        
                        parser.skipChildren();
                    }
                }       
                
            }
        }
        return l;
    }
    
}