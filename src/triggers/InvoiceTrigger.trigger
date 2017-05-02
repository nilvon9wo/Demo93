trigger InvoiceTrigger on Invoice__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) 
{
	if (TRIG_TriggerHandlerInvoker.skipTriggerInvocation()) { return; }
	TRIG_TriggerHandlerInvoker.invoke(new WARE_InvoiceTriggerHandler(Trigger.isExecuting)); 
}