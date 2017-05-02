/**
 * Testing HTTP Callouts by Implementing the HttpCalloutMock Interface
 * Mock Server with successful result for unit test class to test INT_ExternalOrder.cls
 * @author Brian Kessler <brian_kessler@epam.com>
 * @data   2013 July 19
 * @see http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_restful_http_testing_httpcalloutmock.htm
 **/
 @isTest
global class INT_MockHttpResponse200Generator 
				implements HttpCalloutMock				// Implement this interface method 
{
	public static final Integer DUMMY_ORDERNUMBER = 999999999;
	
	public static String crudeConvertId (Id id) { return (''+((String) id).hashCode()).left(6) ; }
	
	// [Inner] class to use for deserializing request body
	class RequestedOrder { public String id {get; set;} }
	
	private static String prepareJsonData(HttpRequest request)
	{
		// Create a list of requested orders by deserializing the JSON data requested from the fulfillment service
		List<RequestedOrder> requestOrderList = (List<RequestedOrder>) JSON.deserialize (request.getBody(), List<RequestedOrder>.class);
		
            JSONGenerator generator = JSON.createGenerator(true);       // Create a JSON generator object
            generator.writeStartArray();                                // Open the JSON generator

                for (RequestedOrder requestOrder: requestOrderList)     // Iterate through the requested orders, deserialized above
                {
                    generator.writeStartObject();
                        generator.writeStringField('id', requestOrder.id);    // Write each invoice Id to the array
                        generator.writeStringField('order_number', crudeConvertId(requestOrder.id));    // Make and include a fictional order number.
                    generator.writeEndObject();
                }

            generator.writeEndArray();                                  // Close the JSON generator
            return generator.getAsString();                             // Create a string from the JSON generator
	}
	
	global HttpResponse respond (HTTPRequest request)
	{
		// Optionally, only send a mock response for a specific endpoint and method.
		System.assertEquals(INT_Integration.INT_ENDPOINT, request.getEndpoint());
		System.assertEquals('POST', request.getMethod());
		
		// Create a fake response.
		HttpResponse response = new HttpResponse();

		// Set response values,

		 			 response.setHeader ('Content-Type', 'application/json');
		 			 response.setStatusCode(200);
					 response.setBody (prepareJsonData(request));
		 
		// ... and return response.		 
		return response;
	}
}