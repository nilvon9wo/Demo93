/**
 *	Calling Salesforce Web Services Using Apex
 *	@see http://developer.force.com/cookbook/recipe/calling-salesforce-web-services-using-apex
 *
 *	---  THE UNIT TESTS IN THIS CLASS NEED A LOT OF WORK as SFDC won't normally test WebServices even against itself.
 *
 *	Either we need to rework the actual code to detect Unit Tests and send back substitute data or we need to write [better] mock server classes.
 *
 **/
 @isTest
private class COOK_ExecuteUnitTestsThruWebServiceTest
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();
	public static final String DUMMY_PASSWORD = 'DummyPassword098%%%';

	private COOK_ExecuteUnitTestsThruWebServiceTest() { System.setPassword (TestRunner.id, DUMMY_PASSWORD); }

	private static testMethod void testLogin()
	{
		System.debug (Logginglevel.INFO, '!!!!!! Begin testLogin();');
		//Test.setMock(WebServiceMock.class, new COOK_ExecUnitTestsThruWSMockLoginWSGen());  
		
		partnerSoapSforceCom.LoginResult loginResult = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	loginResult = COOK_ExecuteUnitTestsThroughWebService.login (TestRunner.name, DUMMY_PASSWORD);
           	} 
            Test.stopTest();
        }

        System.assertEquals (TestRunner.id, loginResult.userId);
		System.debug (Logginglevel.INFO, '!!!!!! End testLogin();');
	}	

	private static testMethod void testWebService()
	{
		System.debug (Logginglevel.INFO, '!!!!!! Begin testWebService();');
       	partnerSoapSforceCom.LoginResult loginResult = COOK_ExecuteUnitTestsThroughWebService.login (TestRunner.name, DUMMY_PASSWORD);

		soapSforceCom200608Apex.Apex apexWebService = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	apexWebService  = COOK_ExecuteUnitTestsThroughWebService.getApexService ((Id)loginResult.sessionId);
            } 
            Test.stopTest();
        }

        System.assertEquals (loginResult.sessionId, apexWebService.SessionHeader.sessionId);
		System.debug (Logginglevel.INFO, '!!!!!! Begin endWebService();');
	}	
	
	private static testMethod void testRunTests()
	{
		System.debug (Logginglevel.INFO, '!!!!!! Begin testRunTests();');
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	COOK_ExecuteUnitTestsThroughWebService.runTests(TestRunner.name, DUMMY_PASSWORD);
            } 
            Test.stopTest();
        }
        
        //TODO: Assert something worthwile about the results.
		System.debug (Logginglevel.INFO, '!!!!!! End testRunTests();');
	}
	
}