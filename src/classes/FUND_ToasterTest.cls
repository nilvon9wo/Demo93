/**
 * Unit Tests for Interface Example
 * @see Apex Workbook, page 29.
 **/
@isTest
private class FUND_ToasterTest 
{
	private static testmethod void testInterface()
	{
		FUND_Fridge  fridge  = new FUND_Fridge('MX', 200);
		FUND_Toaster toaster = new FUND_Toaster();
		FUND_KitchenUtilityInterface[] utilityArray = new FUND_KitchenUtilityInterface[] { fridge, toaster };
	}
	
	private static testmethod void testModelNumber()
	{
		FUND_Toaster toaster = new FUND_Toaster();
		System.assertEquals ('T', toaster.getModelNumber().left(1));		
	}
	
	

}