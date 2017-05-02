/**
 * Unit Test for Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
 @isTest
public class VF_PageControllerImplementedTest 
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void controllerTest()
	{
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	VF_ComponentControllerImplemented component1Controller = new VF_ComponentControllerImplemented();
            	VF_ComponentControllerImplemented component2Controller = new VF_ComponentControllerImplemented();

            	VF_PageControllerImplemented pageController            = new VF_PageControllerImplemented();
            								 pageController.component1Controller = component1Controller;
            								 pageController.component2Controller = component2Controller;
          									 pageController.setComponentControllerMap('component1', new VF_ComponentControllerImplemented());
          									 pageController.setComponentControllerMap('component2', new VF_ComponentControllerImplemented());
          									 
            				   assertValues (pageController, 3, 3);

         									 pageController.callComponent1ControllerMethod();
            				   assertValues (pageController, 4, 3);

							        	     pageController.callComponent2ControllerMethod();
            				   assertValues (pageController, 4, 4);
            }
            Test.stopTest();
        }
        
	}
	
	private static void assertValues (VF_PageControllerImplemented pageController, Integer component1expectedValue, Integer component2expectedValue)
	{
            	      System.assertEquals(component1expectedValue, pageController.component1Controller.getIntValue()); 
            	      System.assertEquals(component2expectedValue, pageController.component2Controller.getIntValue());
	}
	
}