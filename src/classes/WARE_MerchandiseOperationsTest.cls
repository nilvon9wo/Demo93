/**
 * Unit tests for WARE_MerchandiseOperations (Executing Data Operations as Single Transactions)
 * @see Apex Workbook, page 49
 **/
 @isTest
private class WARE_MerchandiseOperationsTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static Id doCreateInvoice (String productName, Integer productSold, String productDescription)
	{
		Id invoiceId = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                invoiceId = WARE_MerchandiseOperations.createInvoice(productName, productSold, productDescription);
            }
            Test.stopTest();
        }
        return invoiceId;
	}
	
	private static Id prepCreateInvoiceTest(TEST_UniqueHelper unique, Boolean hasEnough)
	{
		String  productName 		= unique.uniqueString;
		Integer productSold 		= unique.uniqueInt;
		String  productDescription  = 'Description of ' + productName;
		
		TEST_dummyMerchandiseFactory.Config config = new TEST_dummyMerchandiseFactory.Config();
									 		config.name = productName;
									 		config.quantity = (hasEnough) ? (productSold) : (productSold - 1); 
		Merchandise__c dummyMerchandise = TEST_dummyMerchandiseFactory.createDummy(config, true);
		
		return doCreateInvoice (productName, productSold, productDescription); 
	}
	
	private static testMethod void hasEnoughTest()
	{
		TEST_UniqueHelper unique = new TEST_UniqueHelper('Product With Enough');

		Id invoiceId = prepCreateInvoiceTest(unique, true);
		System.assertNotEquals (null, invoiceId); 

		List<Line_Item__c> lineItem = [SELECT id FROM Line_Item__C WHERE Invoice__c = : invoiceId];
		System.assertEquals (1, lineItem.size());
	}

	private static testMethod void notEnoughTest()
	{
		TEST_UniqueHelper unique = new TEST_UniqueHelper('Product Without Enough');
		Id invoiceId = null;
		Boolean exceptionCaught = false;
		try { invoiceId = prepCreateInvoiceTest(unique, false); }
		catch (WARE_InvoiceException ie)
		{
			System.assertEquals (null, invoiceId);
			exceptionCaught = true; 
		}
		System.assert(exceptionCaught);
	}
}