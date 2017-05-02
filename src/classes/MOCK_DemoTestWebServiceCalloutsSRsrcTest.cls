/**
 * Test coverage for unit testing callouts, using a Static Resource (SRsrc) as the reponse.
 * @see http://sfdcmahi.blogspot.hu/2013/03/test-coverage-for-unit-testing-callouts.html
 **/
 @isTest
public class MOCK_DemoTestWebServiceCalloutsSRsrcTest
{
	public static testmethod void testWebService()
	{
		String testBody = 'This is a test :-)';
		
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
								  mock.setStaticResource('MOCK_Test_WebService');
								  mock.setStatusCode(200);
		
		Test.setMock(HttpCalloutMock.class, mock);
		
		MOCK_DemoTestWebServiceCallouts callout = new MOCK_DemoTestWebServiceCallouts();
		HttpResponse response = callout.invokesWebService();
		
		System.assertEquals(200, response.getStatusCode());
		System.assertEquals(response.getBody(), testBody);
	}
	
}