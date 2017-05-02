/**
 * Test coverage for unit testing callouts.
 * @see http://sfdcmahi.blogspot.hu/2013/03/test-coverage-for-unit-testing-callouts.html
 **/
public class MOCK_DemoTestWebServiceCallouts 
{
	private static final String ENDPOINT_URL = 'http://www.eltoro.it/ServerTime';
	
	public HttpResponse invokesWebService()
	{
		HttpRequest request   = new HttpRequest();
					request.setEndpoint(ENDPOINT_URL);
					request.setMethod('GET');
					
		Http http			  = new Http();
		HttpResponse response = http.send(request);
		System.debug(LoggingLevel.INFO, response.getBody());
		
		return response;
	}
}