/**
 * Example of Apex Batch Processing
 * @see Apex Workbook, page 64
 **/
global class BAT_CleanUpRecords implements Database.Batchable<sObject>
{
	global final String QUERY;
	
	global BAT_CleanUpRecords (String query) { this.query = query; }
	
	global Database.QueryLocator start (Database.BatchableContext batchableContext) { return Database.getQueryLocator (QUERY); }
	
	global void execute (Database.BatchableContext batchableContext, List<sObject> sObjectScopeList)
	{
		delete sObjectScopeList;
		Database.emptyRecycleBin (sObjectScopeList);
	}
	
	global void finish (Database.BatchableContext batchableContext)
	{
		AsyncApexJob asyncJob = [
									SELECT id, status, numberOfErrors, jobItemsProcessed, totalJobItems, createdBy.Email
									FROM AsyncApexJob
									WHERE id = :batchableContext.getJobId()
								];

		String[] toAddresses = new String[] { asyncJob.CreatedBy.Email };
								
		// Send an email to the Apex job's submitter notifying of job completion
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
									 mail.setToAddresses(toAddresses);
									 mail.setSubject('Record Clean Up Status: ' + asyncJob.Status);
									 mail.setPlainTextBody(
									 		'The batch Apex job processed ' + asyncJob.TotalJobItems
									 		+ ' batches with ' + asyncJob.NumberOfErrors + ' failures.'
									 	);
		
		Messaging.sendEmail (new Messaging.SingleEmailMessage[]{mail});
	}
}