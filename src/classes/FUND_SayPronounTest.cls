/**
 * Tests for Hello World Example
 **/
@isTest
private class FUND_SayPronounTest 
{
    private static testmethod void sayMeTest()
    {
        FUND_SayPronoun.sayMe();
        // Normally we would want to assert something, but these methods only write to the logs, which we can't check.
    }

    private static testmethod void sayYouTest()
    {
        FUND_SayPronoun.sayYou();
        // Normally we would want to assert something, but these methods only write to the logs, which we can't check.
    }

}