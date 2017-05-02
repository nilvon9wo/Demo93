/**
 * Unit Test for Accessing Custom Component Attributes in a Controller
 * @see http://www.salesforce.com/us/developer/docs/pages/Content/pages_comp_cust_elements_controllers.htm
 **/
 @isTest
public class VF_CustomComponentControllerTest 
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void controllerTest()
	{
		String dummyString = 'dummy';

		String pageControllerString = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	VF_CustomComponentController controller = new VF_CustomComponentController();
            							     controller.setControllerValue(dummyString);
         		      pageControllerString = controller.getControllerValue();
            }
            Test.stopTest();
        }
        
        System.assertEquals(dummyString.toUpperCase(), pageControllerString);
	}
}