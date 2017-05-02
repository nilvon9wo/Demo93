/**
 * Testing HTTP Callouts by Implementing the HttpCalloutMock Interface
 * Mock Server with failed result for unit test class to test INT_ExternalOrder.cls
 * @author Brian Kessler <brian_kessler@epam.com>
 * @data   2013 July 19
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
 **/
 @isTest
global class INT_MockHttpResponse500Generator 
				implements HttpCalloutMock				// Implement this interface method 
{
	
	global HttpResponse respond (HTTPRequest request)
	{
		// Create a fake response.
		HttpResponse response = new HttpResponse();

		// Set response values,
		 			 response.setHeader ('Content-Type', 'application/json');
		 			 response.setStatusCode(500);
					 response.setBody ('That did not work!');
		 
		// ... and return response.		 
		return response;
	}
}