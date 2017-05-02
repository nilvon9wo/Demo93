/**
 * Unit Tests for example of Apex Batch Processing
 * @see Apex Workbook, page 65
 **/
 @isTest
private class BAT_CleanUpRecordsTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
    
	private static testMethod void batchTest()
	{
		// The query used by the batch job.
		String query = 'SELECT id, createdDate FROM Merchandise__c WHERE id NOT IN (SELECT Merchandise__c FROM Line_Item__c)';

		WARE_MerchandiseCleanTestLists merchandiseTestLists = new WARE_MerchandiseCleanTestLists (10, 10); 

		List<Merchandise__c> dummyMerchandiseNotInLineItemsList = merchandiseTestLists.dummyMerchandiseNotInLineItemsList;
		List<Merchandise__c> dummyMerchandiseInLineItemsList 	= merchandiseTestLists.dummyMerchandiseInLineItemsList; 
				
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                BAT_CleanUpRecords cleanRecords = new BAT_CleanUpRecords(query);
                Database.executeBatch(cleanRecords);
            }
            Test.stopTest();
        }
        
        TEST_DummyMerchandiseFactory.assertMerchandise (dummyMerchandiseNotInLineItemsList, false); // Verify merchandise items without line items got deleted.
		TEST_DummyMerchandiseFactory.assertMerchandise (dummyMerchandiseInLineItemsList, true);     // Verify merchandise items with line items did not get deleted.
	}
	
}