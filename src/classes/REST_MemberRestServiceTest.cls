/**
 * Writing Unit Tests for v24 Apex REST Services
 * @see http://blog.jeffdouglas.com/2012/03/21/writing-unit-tests-for-v24-apex-rest-services/
 **/
 @isTest
private class REST_MemberRestServiceTest 
{
	static
	{
		// setup test data
	}
	
	private static void doGetTest(Integer numberOfmembers) 
	{
		String memberName = (new TEST_UniqueHelper('Member')).uniqueString;

		TEST_DummyContactFactory.Config config = new TEST_DummyContactFactory.Config();
		if (numberOfmembers != 0) { config.memberName = memberName; }
		List<Contact> dummyContactList = TEST_DummyContactFactory.createDummyList(numberOfmembers, config, true);
	
		RestContext.request = setRestRequest(memberName);		// pass the request and response objects to the method
		RestContext.response = (new RestResponse());
		
		REST_MemberRestServiceReturnClass results = REST_MemberRestService.doGet();
		
		System.assertEquals('true', results.success);
		System.assertEquals(numberOfmembers, results.contactList.size()); 
		System.assertEquals('Query executed successfully.', results.message);
	}
	
	private static testMethod void doGetOneMemberTest()  { doGetTest(1);  }
	private static testMethod void doGetTwoMemberTest()  { doGetTest(2);  }
	private static testMethod void doGetTenMemberTest()  { doGetTest(10); }
	
	private static testMethod void doGetTestFail () 
	{
		String memberName = 'ThrowException';

		RestContext.request = setRestRequest(memberName);		// pass the request and response objects to the method
		RestContext.response = (new RestResponse());

		REST_MemberRestServiceReturnClass results = REST_MemberRestService.doGet();
		
		System.assertEquals('false', results.success);
		System.assertEquals(results.message,'Exception Test');
	}
	
	private static RestRequest setRestRequest(String memberName)
	{
		RestRequest request  = new RestRequest();
					request.requestURI = 'https://cs9.salesforce.com/services/apexrest/v.9/member/'+ memberName + '/results/today';
					request.httpMethod = 'GET';
			 return request;
	}
}