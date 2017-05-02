/**
 * Testing HTTP Callouts Using Static Resources
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_static.htm
 **/ 
 @isTest
private class MOCK_CalloutStaticClassTest 
{
	private static testmethod void testCalloutWithStaticResources()
	{
	 	// Use StaticResourceCalloutMock built-in class to specify fake response
		StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
								  mock.setStaticResource ('MOCK_MockResponse');  // ...  and include response body in a static resource
								  mock.setStatusCode(200);
								  mock.setHeader ('Content-Type', 'application/json');
								 
		// Set the mock callout mode
		Test.setMock (HttpCalloutMock.class, mock);
		
		// Call the method that performs the callout
		HttpResponse response = MOCK_CalloutStaticClass.getInfoFromExternalService ('http://api.salesforce.com/foo/bar');
		
		// Verify response received contains values returned by the mock response.
		// This is the content of the static resource.
		System.assertEquals('{"hah":"fooled you"}', response.getBody());
		System.assertEquals(200, response.getStatusCode());
		System.assertEquals('application/json', response.getHeader('Content-Type'));
	}
}