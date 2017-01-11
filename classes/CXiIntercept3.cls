/* Class Name  : CXiIntercept3
 * Description : Class which interacts with on-premise Paymetric servers for Credit Card tokenization.
 * Created By  : Heather Kinney (code as-is from Alex Perez aperez@primesys.com)
 * Created On  : 12-28-2015
 *
 * Modification Log:  
 * --------------------------------------------------------------------------------------------------------------------------------------
 * Developer              Date                   Modification ID       Description 
 * ---------------------------------------------------------------------------------------------------------------------------------------
 * Heather Kinney         12-28-2015             n/a                   Initial version. 
 * Heather Kinney         02-04-2016             n/a                   Added logic to retreive URL, GUID, and PSK via custom labels.                                     
*/

public with sharing class CXiIntercept3 
{
    public String m_strURL;
    public String m_strGUID;
    public String m_strPSK;
    
    public CXiIntercept3()
    {
        m_strURL = System.Label.PaymetricXiURL;
		m_strGUID = System.Label.PaymetricXiGUID;
		m_strPSK = System.Label.PaymetricXiPSK;
    }
    
    public String getXiInterceptURL()
    {
        return m_strURL; 
    }
    
    public String getXiInterceptGUID()
    {
        return m_strGUID; 
    }
    
    public String getXiInterceptPSK()
    {
        return m_strPSK; 
    }
    
    public String getAccessToken()
    {
        String strWhere = 'getAccessToken';
        String strAT = '';
        String strResponse = '';
        String strPostXml = getSignedXML();
        String strURL = m_strURL + '/AccessToken';
        Dom.Document hDoc = null;
        Dom.XmlNode hRoot = null;
        Dom.XmlNode hResponse = null;
        Dom.XmlNode hAT = null;

        Log(strWhere, 'strURL', strURL);
        Log(strWhere, 'strPostXml', strPostXml);
        
        hDoc = executeHttpRequest(strURL, strPostXml, 'POST');
        hRoot = hDoc.getRootElement();
        if(hRoot != null)
        {
            hResponse = hRoot.getChildElement('ResponsePacket', null);
            if(hResponse != null)
            {
                hAT = hResponse.getChildElement('AccessToken', null);
                if(hAT != null)
                    strAT = hAT.getText();
            }
        }
        Log(strWhere, 'AccessToken', strAT);
        
        return strAT; 
    }
    
    public String getCreditCardToken()
    {
        String strWhere = 'getCreditCardToken';
        String strStatus = '' + Apexpages.currentpage().getparameters().get('status');
        String strAccessToken = '';
        String strToken = '';
        Dom.Document hDoc = null;
        Dom.XmlNode hRoot = null;
        Dom.XmlNode hNode = null;

        
        if(strStatus.containsIgnoreCase('cancel'))
            return 'FAILED';

        strAccessToken = Apexpages.currentpage().getparameters().get('id');
        Log(strWhere, 'strAccessToken', strAccessToken);
        hDoc = getResponsePacket(strAccessToken);
        /*
            <?xml version="1.0" encoding="utf-8"?>
            <PaymetricResponse xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <Fields>
                    <FormField>
                        <Name>PaymentCreditCard</Name>
                        <Value>-E803-1111-ZRKEN00000000A</Value>
                        <IsToTokenize>true</IsToTokenize>
                    </FormField>
                </Fields>
            </PaymetricResponse>
        */
        hRoot = hDoc.getRootElement(); // <PaymetricResponse>
        if(hRoot != null)
        {
            hNode = hRoot.getChildElement('Fields', null);
            if(hNode != null)
            {
                hNode = hNode.getChildElement('FormField', null);
                if(hNode != null)
                {
                    hNode = hNode.getChildElement('Value', null);
                    if(hNode != null)
                        strToken = hNode.getText();
                }
            }
        }
        
        return strToken;
    }

    public String getRequestUrl()
    {
        String strWhere = 'getXmlRequest'; 
        String strURL = '' + Site.getBaseUrl();
        
        if(strURL.length() == 0)
        {
            strURL = URL.getCurrentRequestUrl().toExternalForm().replace('XiIntercept3RQ', 'XiIntercept3RS');
        }
        else strURL += '/XiIntercept3RS';
        
        Log(strWhere, 'strURL', strURL);
        Log(strWhere, 'URL.getSalesforceBaseUrl().toExternalForm()', URL.getSalesforceBaseUrl().toExternalForm());
        Log(strWhere, 'URL.getCurrentRequestUrl().toExternalForm()', URL.getCurrentRequestUrl().toExternalForm());
        
        return strURL;
    }

    public String getXmlRequest()
    {
        String strWhere = 'getXmlRequest'; 
        String strRedirect = getRequestUrl();
        String xmlRequest = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
        

        //strRedirect = strRedirect.replace('XiIntercept3RQ', 'XiIntercept3RS');
        xmlRequest += '<PostPacketModel><RedirectUri>' + strRedirect + '</RedirectUri></PostPacketModel>';
        
        Log(strWhere, 'strRedirect', strRedirect);
        Log(strWhere, 'xmlRequest', xmlRequest);
        
        return xmlRequest;
    }
    
    private void Log(String strWhere, String strName, String strValue)
    {
        System.debug(strWhere + '() - ' + strName + ' => ' + strValue);
    }

    private String getDigitalSignature(String strData) 
    {
        String strWhere = 'getDigitalSignature';
        String strSignature = '';
        
        strSignature = EncodingUtil.base64Encode(Crypto.generateMac('hmacSHA256', Blob.valueOf(strData), Blob.valueOf(m_strPSK)));
        Log(strWhere, 'strData', strData);
        Log(strWhere, 'strSignature', strSignature);
        
        return strSignature;
    }

    private String getSignedXML()
    {
        String strWhere = 'getSignedXML';
        String strXml = getXmlRequest();
        String strPostXml = EncodingUtil.urlEncode(strXml, 'UTF-8');
        String strSignature = EncodingUtil.urlEncode(getDigitalSignature(strXml), 'UTF-8');
        String strSigned = 'MerchantGuid=' + m_strGUID + '&' +
                    'SessionRequestType=3&' + 
                    'Packet=' + strPostXml + '&' + 
                    'Signature=' + strSignature + '&' + 
                    'MerchantDevelopmentEnvironment=SalesForce';

        Log(strWhere, 'strXml', strXml);
        Log(strWhere, 'strPostXml', strPostXml);
        Log(strWhere, 'strSignature', strSignature);
        Log(strWhere, 'strSigned', strSigned);
        
        return strSigned;
    }

    private Dom.Document getResponsePacket(String strAccessToken)
    {
        String strWhere = 'getResponsePacket';
        String strSignature = getDigitalSignature(strAccessToken);
        String strUrlParams = m_strURL + '/ResponsePacket';
        Dom.Document hDoc = null;
        
        strUrlParams += '?MerchantGUID=' + m_strGUID;
        strUrlParams += '&Signature=' + EncodingUtil.urlEncode(strSignature, 'UTF-8');
        strUrlParams += '&AccessToken=' + strAccessToken;
        
        Log(strWhere, 'strUrlParams', strUrlParams);
        hDoc = executeHttpRequest(strUrlParams, '', 'GET');
        Log(strWhere, 'hDoc.toXmlString()', hDoc.toXmlString());
        
        return hDoc;
    }
    
    private Dom.Document executeHttpRequest(String targetURL, String urlParameters, String requestType)
    {
        String strWhere = 'executeHttpRequest';
        Dom.Document hDoc = null;
        Http myHttp = new Http();
        HttpRequest httpRQ = new HttpRequest();
        HttpResponse httpRS = null;
        
        Log(strWhere, 'targetURL', targetURL);
        Log(strWhere, 'requestType', requestType);
        Log(strWhere, 'urlParameters', urlParameters);
        
        httpRQ.setEndpoint(targetURL);
        httpRQ.setMethod(requestType);
        if(requestType.equalsIgnoreCase('POST'))
        {
            httpRQ.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpRQ.setHeader('Content-Length', String.valueOf(urlParameters.Length()));
            httpRQ.setHeader('Content-Language', 'en-US');
            httpRQ.setHeader('Cache-Control', 'no-cache, no-store, max-age=0, must-revalidate');
            httpRQ.setHeader('Pragma', 'no-cache');
            httpRQ.setBody(urlParameters);
        }
        
        httpRS = myHttp.send(httpRQ);
        if(httpRS != null)
        {
            Log(strWhere, 'httpRS.getBody()', httpRS.getBody());
            hDoc = httpRS.getBodyDocument();
        }
        else
        {
            hDoc = new Dom.Document();
        }
        
        return hDoc;
    }
}