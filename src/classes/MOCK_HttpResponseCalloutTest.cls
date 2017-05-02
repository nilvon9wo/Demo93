/**
 * Testing HTTP Callouts by Implementing the HttpCalloutMock Interface
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
 **/
 @isTest
public class MOCK_HttpResponseCalloutTest 
{
	public static testmethod void testCallout()
	{
		// Set mock callout class
		Test.setMock (HttpCalloutMock.class, new MOCK_MockHttpResponseGenerator());
		
		// Call method to test
		// This causes a fake response to be sent
		// from the class that implements HttpCalloutMock.
		HttpResponse response = MOCK_HttpResponseCallout.getInfoFromExternalService();
		
		/// verify response received contains fake values
		String contentType = response.getHeader('Content-Type');
		System.assert(contentType == 'application/json');

		String actualValue = response.getBody();
		String expectedValue = '{"foo":"bar"}';
		System.assertEquals(actualValue, expectedValue);
		
		System.assertEquals(200, response.getStatusCode());
	}
}