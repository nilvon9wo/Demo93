/**
 * Testing HTTP Callouts Using Static Resources
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_static.htm
 **/ 
 @isTest
private class MOCK_CalloutMultiStaticClassTest 
{
	private static testmethod void testCalloutWithMultipleStaticResources()
	{
	 	// Use MultiStaticResourceCalloutMock built-in class to specify fake response for a certain endpoint
		MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
								 	// ... and include response body in a static resource.
								  multimock.setStaticResource ('http://api.salesforce.com/foo/bar', 'MOCK_MockResponse'); 
								  multimock.setStaticResource ('http://api.salesforce.com/foo/sfdc','MOCK_MockResponse2'); 
								  multimock.setStatusCode(200);
								  multimock.setHeader ('Content-Type', 'application/json');
								 
		// Set the mock callout mode
		Test.setMock (HttpCalloutMock.class, multimock);
		
		// Call the method that performs the callout
		HttpResponse response  = MOCK_CalloutStaticClass.getInfoFromExternalService ('http://api.salesforce.com/foo/bar');
		// Verify response received contains values returned by the mock response.
		System.assertEquals('{"hah":"fooled you"}', response.getBody());

		HttpResponse response2 = MOCK_CalloutStaticClass.getInfoFromExternalService ('http://api.salesforce.com/foo/sfdc');
		// Verify response received contains values returned by the mock response.
		System.assertEquals('{"hah":"fooled you twice"}', response2.getBody()); 
	}
}