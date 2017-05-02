abstract public class TRIG_TriggerHandlerAbstract implements TRIG_TriggerHandlerInterface 
{
    protected boolean isTriggerExecuting;
    
    public TRIG_TriggerHandlerAbstract(boolean isTriggerExecuting) { this.isTriggerExecuting = isTriggerExecuting; }
    
    public virtual void OnBeforeInsert (List<sObject> newTriggerValuesList) {}
    public virtual void OnAfterInsert  (List<sObject> newTriggerValuesList, Map<ID, sObject> newTriggerValuesMap) {}

    public virtual void OnBeforeUpdate (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) {}
    public virtual void OnAfterUpdate  (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) {}

    public virtual void OnBeforeDelete (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
    public virtual void OnAfterDelete  (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
    
    public virtual void OnAfterUndelete(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
}