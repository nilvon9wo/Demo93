/**
 * Testing HTTP Callouts by Implementing the HttpCalloutMock Interface
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
 **/
global class MOCK_HttpResponseCallout 
{
	public static HttpResponse getInfoFromExternalService()
	{
		HttpRequest request   = new HttpRequest();
					request.setEndpoint('http://api.salesforce.com/foo/bar');
					request.setMethod('GET');
		
		Http http 			  = new Http();
		
		HttpResponse response = http.send(request);
			  return response;
	}
}