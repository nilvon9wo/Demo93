/**
 * Unit Test Class to test InvoiceTriggerHandler.cls, for before update.
 * @see Apex Workbook, page 59.
 * @author Brian Kessler <brian_kessler@epam.com>
 * @data   2013 July 23
 **/
@isTest
private class WARE_InvoiceTriggerHndlrBeforeUpdateTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	private static Set<Id> prepDummyInvoiceLists (Integer numberOfInvoicesWithoutLineItems, Integer numberOfInvoicesWithLineItems)
	{
		List<Invoice__c>     dummyInvoiceList 	  = new List<Invoice__c>();
		
		dummyInvoiceList.addAll(TEST_dummyInvoiceFactory.createDummyList(numberOfInvoicesWithoutLineItems, true));
	
		List<Invoice__c>          dummyInvoiceWithList = TEST_dummyInvoiceFactory.createDummyList(numberOfInvoicesWithLineItems, true);
		dummyInvoiceList.addAll  (dummyInvoiceWithList);
		addLineItemsToInvoiceList(dummyInvoiceWithList);
		
		return (new Map<Id, Invoice__c>(dummyInvoiceList)).keySet();
	}
	
	private static void addLineItemsToInvoiceList(List<Invoice__c> dummyInvoiceWithList)
	{
		List<Merchandise__c> dummyMerchandiseList = new List<Merchandise__c>();
		
		for (Invoice__c dummyInvoice : dummyInvoiceWithList)
		{
			dummyMerchandiseList.add(TEST_dummyMerchandiseFactory.createDummy(false));
		}
		insert dummyMerchandiseList;
		
		List<Line_Item__c> 	 dummyLineItemList    = new List<Line_Item__c>();
		Integer i=0;
		for (Invoice__c dummyInvoice : dummyInvoiceWithList)
		{
			dummyLineItemList.add (TEST_dummyLineItemFactory.createDummy(dummyInvoice, dummyMerchandiseList[i], false));
			i++;
		}
		insert dummyLineItemList;
	}
	
	private static void testInvoiceListSelection(Integer numberOfInvoicesWithoutLineItems, Integer numberOfInvoicesWithLineItems)
	{
		Set<Id> newInvoiceIdSet = prepDummyInvoiceLists (numberOfInvoicesWithoutLineItems, numberOfInvoicesWithLineItems);
		List<Invoice__c> selectedInvoiceList = null;
		
        System.runAs(TestRunner)													
        {
            Test.startTest();
            {
            	selectedInvoiceList = WARE_InvoiceTriggerHandler.selectNewInvoiceWithLineItemsList(newInvoiceIdSet); 
            }
            Test.stopTest();
        }
		
		System.assertEquals((numberOfInvoicesWithoutLineItems + numberOfInvoicesWithLineItems), selectedInvoiceList.size());
		System.assertEquals((numberOfInvoicesWithLineItems), countInvoicesWithLineItems(selectedInvoiceList));
	}	
	
	private static Integer countInvoicesWithLineItems(List<Invoice__c>selectedInvoiceList)
	{
		Integer invoiceCount = 0;

        for (Invoice__c invoice : selectedInvoiceList)
        {
        	if (invoice.Line_Items__r.size() > 0) { invoiceCount++; }
        }
         
        return invoiceCount;
	}
	
	private static testMethod void zeroWithOneWithoutTest()	{ testInvoiceListSelection(    0,    1 ); }
	private static testMethod void oneWithZeroWithoutTest()	{ testInvoiceListSelection(    1,    0 ); }
	private static testMethod void oneWithOneWithoutTest()	{ testInvoiceListSelection(    1,    1 ); }
	private static testMethod void twoWithFiveWithoutTest()	{ testInvoiceListSelection(    2,    5 ); }
	private static testMethod void fiveWithTwoWithoutTest()	{ testInvoiceListSelection(    5,    2 ); }
	private static testMethod void tenWithTenWithoutTest()	{ testInvoiceListSelection(   10,   10 ); }
	
}