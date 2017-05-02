/**
 * Test coverage for unit testing callouts, by extending test class as Mock Server
 * @see http://sfdcmahi.blogspot.hu/2013/03/test-coverage-for-unit-testing-callouts.html
 **/
 @isTest
public class MOCK_DemoTestWebServiceCalloutsMockTest implements HttpCalloutMock
{
	private HttpResponse response;
	
	private MOCK_DemoTestWebServiceCalloutsMockTest (String testBody)
	{
		response = new HttpResponse();
		response.setBody(testBody);
		response.setStatusCode(200);
	}
	
	public HttpResponse respond (HttpRequest request) { return response; }
	
	public static testmethod void testWebService()
	{
		String testBody = 'This is a test :-)';
		
		HttpCalloutMock mock = new MOCK_DemoTestWebServiceCalloutsMockTest (testBody);
		Test.setMock(HttpCalloutMock.class, mock);
		
		MOCK_DemoTestWebServiceCallouts callout = new MOCK_DemoTestWebServiceCallouts();
		HttpResponse response = callout.invokesWebService();
		
		System.assertEquals(200, response.getStatusCode());
		System.assertEquals(response.getBody(), testBody);
	}
	
}