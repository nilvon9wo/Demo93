/**
 * Unit Test for How to get in a Visualforce page controller a value from a custom component controller?
 * @see http://stackoverflow.com/questions/6103363/how-to-get-in-a-visualforce-page-controller-a-value-from-a-custom-component-cont
 **/
 @isTest
public class VF_SelectedAccountPageControllerExtTest 
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void extensionTest()
	{
		Account dummyAccount = TEST_DummyAccountFactory.createDummy(new TEST_DummyAccountFactory.Config('Ext Test Dummy'), true);

		VF_SelectedAccountPageControllerExt ext = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                // Schedule the test job
				ApexPages.Standardcontroller  sc  = new ApexPages.Standardcontroller(dummyAccount);
											  ext = new VF_SelectedAccountPageControllerExt (sc);
											  ext.instanceOfSelectedAccount = new VF_SelectedAccountShell();
											  ext.instanceOfSelectedAccount.account = dummyAccount;
            }
            Test.stopTest();
        }
		
		TEST_DummyAccountFactory.assertEquals(dummyAccount, ext.instanceOfSelectedAccount.account); 
	}
	
}