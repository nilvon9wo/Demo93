/**
 * Integrates to Spring MVC Fulfillment Base
 * @see Integration Workbook, page 7.
 **/ 
public class INT_Integration 
{
    // DON'T FORGET TO UPDATE THE FOLLOWING LINE WITH YOUR appId
    public static final String INT_BASE     = 'https://hidden-plateau-1413.herokuapp.com';
    public static final String INT_ENDPOINT = INT_BASE + '/order';

    private static HttpRequest request { get; set; }                    // Create an HTTPRequest object; class variable for Error Debugging
        
    /**
     * 1) Prepares JSON-formatted data to send to the remote service
     * @param List<Id> invoiceIdList : List of Invoice Ids to include in JSON.
     * @return String : JSON prepared data
     **/
    private static String prepareJsonData(List<Id> invoiceIdList)
    {
            JSONGenerator generator = JSON.createGenerator(true);       // Create a JSON generator object
            generator.writeStartArray();                                // Open the JSON generator

                for (Id invoiceId: invoiceIdList)                       // Iterate through the list of invoices passed in to the call
                {
                    generator.writeStartObject();
                        generator.writeStringField('id', invoiceId);    // Write each invoice Id to the array
                    generator.writeEndObject();
                }

            generator.writeEndArray();                                  // Close the JSON generator
            return generator.getAsString();                             // Create a string from the JSON generator
    }

    /**
     * 2) Makes an HTTP call to send the prepared data to the remote service
     * @param String JSON-formatted string of Orders (e.g., from prepareJsonData())
     * @return HttpResponse : Remote Server response
     **/
     private static HttpResponse sendJsonToRemoteService(String jsonOrders)
     {
            request = new HttpRequest();                                // Create a HTTP Request object
                                                                        // Set up the HTTP request with a...
            request.setMethod('POST');                                  //      method,
            request.setEndpoint(INT_ENDPOINT);                          //      endpoint,
            request.setHeader('Content-Type', 'application/json');      //   header, and
            request.setBody (jsonOrders);                               //      body
                        
            Http http             = new Http();                         // Create a new HTTP object
            return http.send(request);                                  // send the configured HttpRequest and return the result 
     }

    /**
     * 3) Processes any JSON-formatted data returned by the remote service 
     * @param List<Id> invoiceIdList : List of invoice ids
     * @param HttpResponse response : Http response (e.g., from sendJsonToRemoteService())
     * @return List<Invoice__c>     
     **/        
    private static List<Invoice__c> processInvoiceList(List<Id> invoiceIdList, HttpResponse response)
    {
                // Retrieve all of the Invoice objects originally passed into the method call to prep for update.
                List<Invoice__c> invoiceList = [ SELECT Id FROM Invoice__c WHERE Id IN :invoiceIdList ];
        
                // Create a list of external orders by deserializing the JSON data returned by the fulfillment service.
                List<INT_ExternalOrder> orderList = (List<INT_ExternalOrder>) JSON.deserialize (response.getBody(), List<INT_ExternalOrder>.class);
                
                // Create a map of Invoice Ids from the retrieved invoices list.
                Map<Id, Invoice__c> invoiceMap = new Map<Id, Invoice__c>(invoiceList);
                
                // Update the order numbers in the invoices
                for (INT_ExternalOrder order : orderList)
                {
                    Invoice__c invoice = invoiceMap.get(order.id);
                               invoice.OrderId__c = String.valueOf(order.order_number);
                }  

                return invoiceList;
    }
    
    /**
     * Write debugging information
     * @param HttpResponse response : Http response (e.g., from sendJsonToRemoteService())
     * @return None
     **/
    private static void debugResponse (HttpResponse response)
    {
        System.debug(                                                   
                    LoggingLevel.ERROR , 
                    '!!!!! Error from ' + request.getEndpoint() + ' : ' + response.getStatusCode() + ' ' + response.getStatus()
                    ); 
    }
    
    /**
     *  The postOrder method integrates the local Force.com invoicing system with a remote fulfillment system;
     *      specifically, by posting data about closed orders to the remote system.
     *
     *  Functionally, the method:
     *      1) Prepares JSON-formatted data to send to the remote service;
     *      2) Makes an HTTP call to send the prepared data to the remote service; and then
     *      3) Processes any JSON-formatted data returned by the remote service 
     *          to update the local Invoices with the corresponding external Ids in the remote system.
     **/
     @future (callout=true) // indicates that this is an asynchronous call
     public static void postOrder(List<Id> invoiceIdList)
     {
        // 1) Prepares JSON-formatted data to send to the remote service
            String jsonOrders = prepareJsonData(invoiceIdList);                 // Create a string from the JSON generator
            System.debug(LoggingLevel.INFO, '##### jsonOrders: ' + jsonOrders); // debugging call, which you can check in the console logs
            
        // 2) Makes an HTTP call to send the prepared data to the remote service
            HttpResponse response = sendJsonToRemoteService(jsonOrders);        // Create a new HTTP response for receiving the remote response
            System.debug(LoggingLevel.INFO, '##### Fulfillment service returned ' + response.getBody()); // debugging call, which you can check in the console logs
            
        // 3) Processes any JSON-formatted data returned by the remote service 
            // Examine the status code from HttpResponse
            if (response.getStatusCode() != 200) { debugResponse (response); }
            else { update (processInvoiceList(invoiceIdList, response)); }                  // If status code = 200,
     }
     
     // Continue on Page 9 (but consider finishing test unit first!)
}