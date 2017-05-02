/**
 * Unit Test for Scheduled Execution of Apex
 * @see Apex Workbook, page 61.
 **/
 @isTest
private class WARE_InsertMerchandiseSchedulerTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
    
     // CRON expression: midnight on March 15. Because this is a test, job executes immediately after Test.stopTest().
     public static final String CRON_EXP  = '0 0 0 15 3 ? 2022';
     public static final String NEXT_FIRE = '2022-03-15 00:00:00';
     
     private static testMethod void scheduleTest()
     {
        String merchandiseName = WARE_InsertMerchandiseScheduler.SCHEDULED_MERCHANDISE_NAME; 
        
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                // Schedule the test job
                Id jobId = System.schedule('ScheduledApexClassTest', CRON_EXP, new WARE_InsertMerchandiseScheduler());
                TEST_SchedulableHelper.assertCronTrigger(jobId, CRON_EXP, NEXT_FIRE);
	            TEST_DummyMerchandiseFactory.assertMerchandise (merchandiseName, false);                                 // Verify the scheduled job hasn't run yet              
            }
        Test.stopTest();
        }
        
        // Now that the scheduled job has executed after Test.stopTest(), verify the merchandise  got added.
        TEST_DummyMerchandiseFactory.assertMerchandise (merchandiseName, true);                                                  
     }

}