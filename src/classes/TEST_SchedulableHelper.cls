/**
 * Methods to facilitate testing Schedulable classes.
 **/
@isTest
public class TEST_SchedulableHelper 
{
     public static void assertCronTrigger(Id jobId, String cronExpression, String nextFireTime)
     {
            // Get the information from the CronTrigger API object
            CronTrigger cronTrigger = [
                                        SELECT id, cronExpression, timesTriggered, nextFireTime
                                        FROM CronTrigger
                                        WHERE id = :jobId
                                    ];
            
            System.assertEquals(cronExpression, cronTrigger.cronExpression);                // Verify the expressions are the same
            System.assertEquals(0, cronTrigger.timesTriggered);                         	// Verify the job has not run
            System.assertEquals(nextFireTime, String.valueOf(cronTrigger.nextFireTime));    // Verify the next time the job will run
     }  

}