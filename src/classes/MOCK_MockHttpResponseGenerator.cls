/**
 * Testing HTTP Callouts by Implementing the HttpCalloutMock Interface
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
 **/
 @isTest
global class MOCK_MockHttpResponseGenerator 
				implements HttpCalloutMock				// Implement this interface method 
{
	
	global HttpResponse respond (HTTPRequest request)
	{
		// Optionally, only send a mock response for a specific endpoint and method.
		System.assertEquals('http://api.salesforce.com/foo/bar', request.getEndpoint());
		System.assertEquals('GET', request.getMethod());
		
		// Create a fake response.
		HttpResponse response = new HttpResponse();

		// Set response values,

		 			 response.setHeader ('Content-Type', 'application/json');
		 			 response.setBody ('{"foo":"bar"}');
		 			 response.setStatusCode(200);
		 
		// ... and return response.		 
		return response;
	}
}