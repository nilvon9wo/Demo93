/**
 * Unit Test Class to test InvoiceTriggerHandler.cls, for before delete.
 * @see Apex Workbook, page 54.
 * @author Brian Kessler <brian_kessler@epam.com>
 * @data   2013 July 19
 **/
@isTest
private class WARE_InvoiceTriggerHndlrBeforeDeleteTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static List<Database.DeleteResult> tryDeleteInvoice(List<Invoice__c> dummyInvoiceList, Boolean partialShouldSucceed)
	{
		Boolean opt_allOrNone				   = !partialShouldSucceed;
		Boolean caughtDmlException 			   = false;
    	List<Database.DeleteResult> resultList = null;
    
        System.runAs(TestRunner)													
        {
            Test.startTest();
            {
                try   { resultList = Database.delete (dummyInvoiceList, opt_allOrNone); } // if opt_allOrNone is false, Exception won't be caught!
                catch (System.DmlException de) { caughtDmlException = true; }
            }
            Test.stopTest();
        }

		System.assertEquals ((opt_allOrNone && (!partialShouldSucceed)), caughtDmlException);
		return 	(resultList);															  // This value will be null when Exception is caught!
	}

	private static void tryDeleteInvoice(Invoice__c dummyInvoice, Boolean shouldSucceed)
	{
		tryDeleteInvoice(new List<Invoice__c> {dummyInvoice}, shouldSucceed);
	}

	public static void hasLineItemsTest(Integer numberOfLineItems)  
	{
		// Create an invoice statement with requisit line items (if any)
		Invoice__c dummyInvoice = TEST_DummyInvoiceFactory.createDummy(true);
		List<Line_Item__c> dummyLineItemList = TEST_DummyLineItemFactory.createDummyList(numberOfLineItems, (new TEST_DummyLineItemFactory.Config(dummyInvoice.id)), true );
		
		// ... Then try to delete it.
		tryDeleteInvoice(dummyInvoice, (numberOfLineItems == 0));
		
		// We can't check Database.DeleteResult if/as we have already caught and checked the System.DmlException which nullified the result.
		// Anyway, that test would be redundant.

		Boolean hasRows = true;
		try { Invoice__c afterDeleteAttemptInvoice = [SELECT id FROM Invoice__c WHERE id = :dummyInvoice.id LIMIT 1]; }
		catch (System.QueryException qe) { hasRows = false; }
		System.assertEquals((numberOfLineItems != 0), hasRows);
	}
	
	public static testMethod void hasNoLineItemsTest()  { hasLineItemsTest(0);   }	// Verify invoice without a line item gets deleted.
	public static testMethod void hasOneLineItemsTest()  { hasLineItemsTest(1);  }  // Verify invoice with a line item doesn't get deleted.
	public static testMethod void hasTwoLineItemsTest()  { hasLineItemsTest(2);  }
	public static testMethod void hasTenLineItemsTest()  { hasLineItemsTest(10); }
	
	public static testMethod void testBulkDeleteInvoices()
	{
		// Create two invoice statements, one with and one without Line Items
		List<Invoice__c> dummyInvoiceList = TEST_DummyInvoiceFactory.createDummyList(2, true);
		Line_Item__c dummyLineItem		  = TEST_DummyLineItemFactory.createDummy(dummyInvoiceList[0], TEST_DummyMerchandiseFactory.createDummy(true), true);
		
		// Then try to delete them both in a bulk operation, as might happen when a trigger fires.
		List<Database.DeleteResult> resultList = tryDeleteInvoice(dummyInvoiceList, true);
		
		System.assert(!resultList[0].isSuccess());									// Verify the invoice with the line item didn't get deleted
		System.assert(resultList[1].isSuccess());									// Verify the invoice without the line item did get deleted
	}
}