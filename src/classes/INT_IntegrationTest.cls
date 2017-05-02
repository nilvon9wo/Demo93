/**
 *  Unit Test Class to test INT_Integration.cls
 *  @author Brian Kessler <brian_kessler@epam.com>
 *  @data   2013 July 19
 **/
@isTest
public class INT_IntegrationTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

    private static void integrationTest(Integer numberOfInvoices, boolean isSuccess) 
    {
		// This causes a fake response to be generated 
		Test.setMock(HttpCalloutMock.class, ( isSuccess
													? (HttpCalloutMock) new INT_MockHttpResponse200Generator()
													: (HttpCalloutMock) new INT_MockHttpResponse500Generator()
											));  
    	
        List<Invoice__c> dummyInvoiceList = TEST_DummyInvoiceFactory.createDummyList(numberOfInvoices, true); 
        List<Id> invoiceIdList = new List<Id>();
        for (Invoice__c invoice : dummyInvoiceList) { invoiceIdList.add(invoice.id); }
        
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                INT_Integration.postOrder(invoiceIdList);
            }
            Test.stopTest();
        }
        
        List<Invoice__c> updatedInvoiceList = [SELECT id, OrderId__c FROM Invoice__c WHERE id IN :invoiceIdList];
        
        for (Invoice__c updatedInvoice : updatedInvoiceList)
        {
	        // Assert somethings!
        	if (isSuccess)
        	{
		        System.assertEquals(INT_MockHttpResponse200Generator.crudeConvertId(updatedInvoice.id), updatedInvoice.OrderId__c);
        	}
        	else
        	{
		        System.assertNotEquals(INT_MockHttpResponse200Generator.crudeConvertId(updatedInvoice.id), updatedInvoice.OrderId__c);
		        // It would be nice to make some positive assertions, but we can't do this unless we refactor INT_Integration to expose the HTTP Response
		        // @see http://stackoverflow.com/questions/17742123/is-it-possible-for-an-sfdc-apex-unit-test-to-parse-a-debug-log
        	}
        }	        
    }
    
    private static void integrationSuccessTest(Integer numberOfInvoices) { integrationTest (numberOfInvoices, true); } 
    
    public static testmethod void oneInvoiceIntegrationSuccessTest() { integrationSuccessTest(1);  }
    public static testmethod void twoInvoiceIntegrationSuccessTest() { integrationSuccessTest(2);  }
    public static testmethod void tenInvoiceIntegrationSuccessTest() { integrationSuccessTest(10); }

    private static void integrationFailTest(Integer numberOfInvoices) { integrationTest (numberOfInvoices, false); } 

    public static testmethod void oneInvoiceIntegrationFailTest() { integrationFailTest(1);  }
    public static testmethod void twoInvoiceIntegrationFailTest() { integrationFailTest(2);  }
    public static testmethod void tenInvoiceIntegrationFailTest() { integrationFailTest(10); }
    
    
}