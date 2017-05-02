/**
 * Unit Test for Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
 @isTest
public class VF_ComponentControllerImplementedTest 
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void controllerTest()
	{
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	VF_ComponentControllerImplemented controller = new VF_ComponentControllerImplemented();
            	
            	for (Integer i=3; i<=100; i++)
            	{
      			           System.assertEquals(i, controller.getIntValue());
      											  controller.incrementValue();
            	}
      					         						
            }
            Test.stopTest();
        }
        
	}
}