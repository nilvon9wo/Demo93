/**
 * Unit Tests for How to get in a Visualforce page controller a value from a custom component controller?
 * @see http://stackoverflow.com/questions/6103363/how-to-get-in-a-visualforce-page-controller-a-value-from-a-custom-component-cont
 **/
 @isTest
public class VF_SelectedAccountComponentCtrlTest 
{
	public static testMethod void controlerTest()
	{
		Account account = TEST_DummyAccountFactory.createDummy();										   

		VF_SelectedAccountComponentController controller = new VF_SelectedAccountComponentController();
											   controller.selectedAccountShell = new VF_SelectedAccountShell();
											   controller.selectAccountFromUI(account);
											   
		TEST_DummyAccountFactory.assertEquals(account, controller.selectedAccountShell.account);
	}
}