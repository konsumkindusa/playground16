public with sharing class Utils {
	public static String formatAddress( String pStreet, String pCity, String pState, String pZip ) {
        String formattedAddress = ' ';
        if( String.isNotBlank( pStreet ) ) {
            formattedAddress = appendComma( pStreet, formattedAddress );
        }        
        if( String.isNotBlank( pCity ) ) {
            formattedAddress = appendComma( pCity, formattedAddress );
        }
        if( String.isNotBlank( pState ) ) {
            formattedAddress = appendComma( pState, formattedAddress );
        }
        if( String.isNotBlank( pZip ) ) {
            formattedAddress = appendComma( pZip, formattedAddress );
        }
        return formattedAddress;
    }
    public static String appendComma( String pAppend, String pAppendTo ) {
        String commaSeperated = pAppendTo;
        if( String.isNotBlank(pAppendTo) ) {
            commaSeperated = commaSeperated + ', ' + pAppend;
        } else {
            commaSeperated = pAppend;
        } 
        return commaSeperated;
    }
}