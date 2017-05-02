/**
 * Trigger Handler for Album sObject
 * @author Brian Kessler <brian_kessler@epam.com>
 * @date 2013 August 13
 **/
public with sharing class MUS_AlbumTriggerHandler extends TRIG_TriggerHandlerAbstract
{
    public boolean IsTriggerContext { get { return isTriggerExecuting;} }
    public MUS_AlbumTriggerHandler (boolean isTriggerExecuting){ super(isTriggerExecuting); }

    //------------------------------------------------------------------------------------------------------------------
	
    public override void OnBeforeInsert (List<sObject> newTriggerValuesList) {}
    public override void OnAfterInsert  (List<sObject> newTriggerValuesList, Map<ID, sObject> newTriggerValuesMap) {}

    public override void OnBeforeUpdate (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) {}
    public override void OnAfterUpdate  (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) {}

    public override void OnBeforeDelete (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) 
    {
    	deleteRestrictAlbums(oldTriggerValuesList, oldTriggerValuesMap);
    }
    
	/**
     * With each of the albums targeted by the trigger, -- if it has tracks -- add an error to prevent the album from being deleted.
     * @see Database Workbook, page 33.
     * @see https://gist.github.com/sbob909/1132445
     **/
    private void deleteRestrictAlbums(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap)
    {
		for (Album__c album : [
								SELECT id
								FROM Album__c
								WHERE (id IN (SELECT Album__c FROM Track__c))
									AND ((id IN :oldTriggerValuesList))
								])
		{
			oldTriggerValuesMap.get(album.id).addError('Cannot delete album with tracks');	
		}    	
    }
    
    public override void OnAfterDelete  (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
    
    public override void OnAfterUndelete(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
}