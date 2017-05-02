/**
 * Testing Web Service Callouts
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_callouts_wsdl2apex_testing.htm
 * @see http://salesforce-evershine-knowledge.blogspot.hu/2012/10/testing-web-service-callouts.html
 **/
@isTest
public class MOCK_WebServiceCalloutTest 
{
	public static testmethod void testEchoString()
	{
		// This causes a fake response to be generated 
		Test.setMock(WebServiceMock.class, new MOCK_MockWebServiceGenerator());  
		
		// Call the method that invokes a callout
		String output = MOCK_WebServiceCallout.callEchoString('Hello World!');
		
		// Verify that a fake result is returned
		System.assertEquals('Mock response', output);
	}
}