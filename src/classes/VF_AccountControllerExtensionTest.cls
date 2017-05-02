/**
 *	Unit test of example of a controller Extension.
 *  @see VisualForce Workbook, page 36.
 **/
 @isTest
public class VF_AccountControllerExtensionTest 
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void extensionTest()
	{
		Account account = TEST_DummyAccountFactory.createDummy(new TEST_DummyAccountFactory.Config('Ext Test Dummy'), true);

		VF_AccountControllerExtension ext = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                // Schedule the test job
				ApexPages.Standardcontroller  sc  = new ApexPages.Standardcontroller(account);
											  ext = new VF_AccountControllerExtension (sc);
            }
            Test.stopTest();
        }
		
		System.assertEquals(ext.account, account); 
		System.assert(ext.getTitle().contains('Ext Test Dummy')); 
	}
}