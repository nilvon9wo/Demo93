trigger AlbumTrigger on Album__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) 
{
	if (TRIG_TriggerHandlerInvoker.skipTriggerInvocation()) { return; }
	TRIG_TriggerHandlerInvoker.invoke(new MUS_AlbumTriggerHandler(Trigger.isExecuting));   
}