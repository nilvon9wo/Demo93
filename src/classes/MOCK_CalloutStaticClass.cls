/** 
 * Testing HTTP Callouts Using Static Resources
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_static.htm
 **/
public class MOCK_CalloutStaticClass 
{
	public static HttpResponse getInfoFromExternalService (String endpoint)
	{
		HttpRequest request = new HttpRequest();
					request.setEndpoint(endpoint);
					request.setMethod('GET');
					
		Http http = new Http();
		return http.send(request);
	}
}