@isTest
public with sharing class Test_Utils {
	@isTest
	private static void utils1(){
		String formattedAddress = Utils.formatAddress('Street', 'City', 'State', 'Zip');
		String commaAppended = Utils.appendComma('Before', 'After');
	}
}