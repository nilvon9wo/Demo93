/**
 *  Unit Test Class to test InvoiceTriggerHandler.cls, for after update.
 *  @author Brian Kessler <brian_kessler@epam.com>
 *  @data   2013 July 19
 **/
@isTest
private class INT_InvoiceTriggerHandlerAfterUpdateTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
    
    private static final String PRESET_ORDER_ID = '999999';

	private static void afterUpdateTest(String status, String orderId)
	{
		// This causes a fake response to be generated 
		Test.setMock(HttpCalloutMock.class, new INT_MockHttpResponse200Generator());
		
		TEST_DummyInvoiceFactory.Config config = new TEST_DummyInvoiceFactory.Config(); 
										config.status  = status; 
										config.orderId = orderId;
										
        Invoice__c dummyInvoice = TEST_DummyInvoiceFactory.createDummy(config, true); 
        
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                dummyInvoice.Status__c = 'Closed';
                update dummyInvoice;
            }
            Test.stopTest();
        }
        
        Invoice__c updatedInvoice = [SELECT id, OrderId__c FROM Invoice__c WHERE id = :dummyInvoice.id LIMIT 1];
        
        System.assertEquals( (
        						(status != 'Closed')
        							? INT_MockHttpResponse200Generator.crudeConvertId(updatedInvoice.id)
        							: ((orderId != '') ? PRESET_ORDER_ID : null)
        					 ),
        					 updatedInvoice.OrderId__c
        				);
	}
	
	public static testmethod void OpenNoOrderIdAfterUpdateTest()     	  { afterUpdateTest('Open', ''); 						}
	public static testmethod void OpenWithOrderIdAfterUpdateTest()        { afterUpdateTest('Open', PRESET_ORDER_ID);			}
	public static testmethod void NegotiatingNoOrderIdAfterUpdateTest()   { afterUpdateTest('Negotiating', '');					}
	public static testmethod void NegotiatingWithOrderIdAfterUpdateTest() { afterUpdateTest('Negotiating', PRESET_ORDER_ID);	}
	public static testmethod void PendingNoOrderIdAfterUpdateTest()       { afterUpdateTest('Pending', ''); 					}
	public static testmethod void PendingWithOrderIdAfterUpdateTest()     { afterUpdateTest('Pending', PRESET_ORDER_ID);		}
	public static testmethod void ClosedNoOrderIdAfterUpdateTest()        { afterUpdateTest('Closed', '');						}
	public static testmethod void ClosedWithOrderIdAfterUpdateTest()      { afterUpdateTest('Closed', PRESET_ORDER_ID);			}
}