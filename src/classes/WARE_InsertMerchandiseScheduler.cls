/**
 * For Scheduled Execution of Apex
 * @see Apex Workbook, page 60.
 **/
global class WARE_InsertMerchandiseScheduler implements Schedulable 
{
    public static final String SCHEDULED_MERCHANDISE_NAME = 'Scheduled Job Item';
    global void execute (SchedulableContext context)
    {
        CronTrigger cronTrigger = [
                                    SELECT id, cronExpression, timesTriggered, nextFireTime
                                    FROM CronTrigger
                                    WHERE id = :context.getTriggerId()
                                ];
                                
        System.debug(LoggingLevel.INFO, cronTrigger.cronExpression);
        System.debug(LoggingLevel.INFO, cronTrigger.timesTriggered);
        
        Merchandise__c merchandise = new Merchandise__c (
                                            name            = SCHEDULED_MERCHANDISE_NAME,
                                            description__c  = 'Created by the scheduler',
                                            price__c        = 1,
                                            quantity__c     = 1000
                                );
                insert merchandise;
    }
}