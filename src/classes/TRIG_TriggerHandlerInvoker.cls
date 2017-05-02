public class TRIG_TriggerHandlerInvoker 
{
	private static final boolean DEFAULT_SKIP_TRIGGERS_VALUE = false;

	/**
	 * Evaluate global trigger execution.
	 */
	public static boolean skipTriggerInvocation() 
	{
		boolean result = General_Settings__c.getInstance().Skip_Triggers__c;
		 
		if (result == null) 
		{
			// Value is not set, setting a default value
			result = DEFAULT_SKIP_TRIGGERS_VALUE;
		}
		
		// consider the global 'skipTriggers' flag only in real executions (and do NOT if invoked from unit tests)
		// return ! Test.isRunningTest() && result;  
		return result;  // I don't know why we might want to skip tests so I am not including that condition here.
	}
	
	/**
	 * Invoke the trigger handler according to the trigger type.
	 * Trigger.old => oldValues
	 * Trigger.new => newValues
	 * Trigger.oldMap => oldValuesMap
	 * Trigger.newMap => newValuesMap
	 */
    public static void invoke(TRIG_TriggerHandlerInterface handler) 
    {
        	 if (Trigger.isBefore && Trigger.isInsert) { handler.OnBeforeInsert(Trigger.new); 					                           } 
        else if (Trigger.isAfter  && Trigger.isInsert) { handler.OnAfterInsert(Trigger.new, Trigger.newMap);                               } 
        else if (Trigger.isBefore && Trigger.isUpdate) { handler.OnBeforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap); } 
        else if (Trigger.isAfter  && Trigger.isUpdate) { handler.OnAfterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);  } 
        else if (Trigger.isBefore && Trigger.isDelete) { handler.OnBeforeDelete(Trigger.old, Trigger.oldMap);                              } 
        else if (Trigger.isAfter  && Trigger.isDelete) { handler.OnAfterDelete(Trigger.old, Trigger.oldMap);                               } 
        else if (Trigger.isUndelete					 ) { handler.OnAfterUndelete(Trigger.old, Trigger.oldMap);                             }
    }
}