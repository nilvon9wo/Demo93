/**
 *	Calling Salesforce Web Services Using Apex
 *	@see http://developer.force.com/cookbook/recipe/calling-salesforce-web-services-using-apex
 **/
public class COOK_ExecuteUnitTestsThroughWebService 
{
	/**
	 *  For demonstration purposes.
	 *  If we wanted to use this a lot, credentials could/should be encrypted for storage and decrypted here.
	 **/
	public static void runTests (String username, String password)
	{
		partnerSoapSforceCom.LoginResult loginResult    = login (username, password);
		soapSforceCom200608Apex.Apex     apexWebService = getApexService (loginResult.sessionId);
		
		soapSforceCom200608Apex.RunTestsRequest testsRequest = new soapSforceCom200608Apex.RunTestsRequest();
											    testsRequest.allTests = true;
												     
		soapSforceCom200608Apex.RunTestsResult  testResults  = apexWebService.runTests(testsRequest);
		
		//TODO:  Do something worthwhile with the test results here. 
	}
	
	@testVisible private static partnerSoapSforceCom.LoginResult login (String username, String password)
	{
		partnerSoapSforceCom.Soap soap = new partnerSoapSforceCom.Soap();
						   return (Test.isRunningTest()) ? soap.login(username, password) : dummyLogin(username);
	}
	
	
	private static partnerSoapSforceCom.LoginResult dummyLogin (String username)
	{
		partnerSoapSforceCom.LoginResult loginResult = new partnerSoapSforceCom.LoginResult();
										 loginResult.userId = ([SELECT id FROM User WHERE name = :username LIMIT 1]).id;
								  return loginResult;
	}
	
	@testVisible private static soapSforceCom200608Apex.Apex getApexService (Id loginResultSessionId)
	{
		soapSforceCom200608Apex.SessionHeader_element sessionHeader = new soapSforceCom200608Apex.SessionHeader_element();
				   									  sessionHeader.sessionId = loginResultSessionId;

		soapSforceCom200608Apex.Apex apexWebService = new soapSforceCom200608Apex.Apex();
									 apexWebService.timeout_x = 120000; // The Web Services have a maximum timeout of 2 minutes (timeout value is in milliseconds).	
									 apexWebService.SessionHeader   = sessionHeader;
							  return apexWebService;
	}
	
}