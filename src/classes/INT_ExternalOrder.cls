/**
 * The EternalOrder class holds a string and integer received from the external fulfillment system.
 *
 * Integrates to Spring MVC Fulfillment Base
 * @see Integration Workbook, page 7.
 **/
public class INT_ExternalOrder  
{
    public String id            {get; set;}
    public Integer order_number {get; set;}
}