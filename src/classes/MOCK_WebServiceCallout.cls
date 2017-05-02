/**
 * Testing Web Service Callouts
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_callouts_wsdl2apex_testing.htm
 * @see http://salesforce-evershine-knowledge.blogspot.hu/2012/10/testing-web-service-callouts.html
 **/
public class MOCK_WebServiceCallout 
{
	public static String callEchoString (String input)
	{
		MOCK_DocSample.DocSamplePort sample = new MOCK_DocSample.DocSamplePort(); 
								sample.endpoint_x = 'http://api.salesforce.com/foo/bar';
								
		// This invokes the EchoString method in the generated class
		String echo = sample.EchoString(input);
		
		return echo;
	}
}