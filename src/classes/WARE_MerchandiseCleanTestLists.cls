/**
 * Unit Tests for example of Apex Batch Processing
 * @see Apex Workbook, page 65
 **/
@isTest
public class WARE_MerchandiseCleanTestLists
{
    	public List<Merchandise__c> dummyMerchandiseNotInLineItemsList = null;
    	public List<Merchandise__c> dummyMerchandiseInLineItemsList    = null;
    	
    	public WARE_MerchandiseCleanTestLists() {}
    	
    	public WARE_MerchandiseCleanTestLists(Integer numberOfMerchandiseNotInLineItems, Integer numberOfMerchandiseInLineItems)
    	{
			// Create some test merchandise items to be deleted by the batch job.
			this.dummyMerchandiseNotInLineItemsList = TEST_DummyMerchandiseFactory.createDummyList(numberOfMerchandiseNotInLineItems, true);
	
			// Create some test merchandise items to be kept after the batch job (to test against false positives).
			this.dummyMerchandiseInLineItemsList 	= TEST_DummyMerchandiseFactory.createDummyList(numberOfMerchandiseInLineItems, true);
			addLineItemsForMerchandise(this.dummyMerchandiseInLineItemsList);
	    }

		private static void addLineItemsForMerchandise(List<Merchandise__c> merchandiseList)
		{
			List<Invoice__c> dummyInvoiceInLineItemsList 			= TEST_DummyInvoiceFactory.createDummyList(merchandiseList.size(), true);
	
			List<Line_Item__c> dummyLineItemList = new List<Line_Item__c>();
			Integer i = 0;
			for (Merchandise__c dummyMerchandise : merchandiseList)
			{
				dummyLineItemList.add(TEST_DummyLineItemFactory.createDummy(dummyInvoiceInLineItemsList[i], dummyMerchandise , false));
				i++;
			}
			
			insert dummyLineItemList;
		}

}