/**
 * Example of scheduling Apex Batch Processing
 * @see Apex Workbook, page 68
 **/
global class WARE_CleanMerchandiseScheduler implements Schedulable 
{
	global void execute (SchedulableContext context)
	{
		// The query used by the batch job.
		String query = 'SELECT Id, CreatedDate FROM Merchandise__c WHERE Id NOT IN (SELECT Merchandise__c FROM Line_Item__c)';
		
		BAT_CleanUpRecords cleanRecords = new BAT_CleanUpRecords (query);
		Database.executeBatch(cleanRecords);
	}
}