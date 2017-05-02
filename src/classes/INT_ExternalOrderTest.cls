/**
 * @description Unit Test Class to test INT_ExternalOrder.cls       
 * @author      Brian Kessler <Brian_Kessler@epam.com>
 * @date            2013 July 18
 **/
@isTest
public class INT_ExternalOrderTest 
{
    /**
     * @description Method to simply create and populate an ExternalOrder       
     * @author      Brian Kessler <Brian_Kessler@epam.com>
     * @date            2013 July 18
     **/
    public static testmethod void orderTest()
    {
        INT_ExternalOrder order              = new INT_ExternalOrder();
                          order.id           = 'abcde';
                          order.order_number = 1;
                          
        // If the target class were not so simple, assertions could/should go here.
    }
}