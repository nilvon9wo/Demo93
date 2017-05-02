/**
 * Unit test for How to get in a Visualforce page controller a value from a custom component controller?
 * @see http://stackoverflow.com/questions/6103363/how-to-get-in-a-visualforce-page-controller-a-value-from-a-custom-component-cont
 **/
 @isTest
public class VF_SelectedAccountShellTest 
{
	public static testMethod void shellTest()
	{
		Account dummyAccount = TEST_DummyAccountFactory.createDummy();
		
		VF_SelectedAccountShell shell = new VF_SelectedAccountShell();
								shell.account = dummyAccount;
		Account shellAccount =  shell.account;
		
		TEST_DummyAccountFactory.assertEquals(dummyAccount, shellAccount);
	}
}