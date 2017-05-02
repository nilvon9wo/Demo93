public interface TRIG_TriggerHandlerInterface 
{
    void OnBeforeInsert(List<sObject> newTriggerValuesList);
    void OnAfterInsert (List<sObject> newTriggerValuesList, Map<ID, sObject> newTriggerValuesMap);

    void OnBeforeUpdate(List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap);
    void OnAfterUpdate (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap);

    void OnBeforeDelete(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap);
    void OnAfterDelete (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap);
    
    void OnAfterUndelete(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap);
}