/**
 * Exception Handling example
 * @see Apex Workbook, page 46.
 **/
public class WARE_MerchandiseUtility 
{
	public static void mainProcessing(Merchandise__c merchandise)
	{
		try { insertMerchandise(merchandise); }
		catch (WARE_MerchandiseException me) { WARE_WarehouseException.debug((WARE_WarehouseException) me); }
	}
	
	private static void insertMerchandise(Merchandise__c merchandise)
	{
		try { insert merchandise; }										// Insert merchandise (maybe without required fields).
		catch (DmlException e)
		{
			// Something happened that prevents the insertion of Employee custom objects, so throw a more specific exception.
			throw new WARE_MerchandiseException ('Merchandise item could not be inserted.', e);			 
		}
	}
}