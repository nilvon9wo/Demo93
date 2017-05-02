/**
 * Message Maker Example
 * @see Apex Workbook, page 11.
 **/
@isTest
private class FUND_MessageMakerTest 
{
    {
        String message = FUND_MessageMaker.helloMessage();
        System.assert (message.contains('Hello'));
    }
}