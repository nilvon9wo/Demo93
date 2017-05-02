public with sharing class WARE_InvoiceTriggerHandler extends TRIG_TriggerHandlerAbstract
{
    public boolean IsTriggerContext { get { return isTriggerExecuting;} }
    public WARE_InvoiceTriggerHandler (boolean isTriggerExecuting){ super(isTriggerExecuting); }

    //------------------------------------------------------------------------------------------------------------------

    /**
     * Example of running Apex within Governor Execution Limits ("Bulkifying")
     * @see Apex Workbook, page 59.
     **/ 
    public override void OnBeforeInsert (List<sObject> newTriggerValuesList) 
    {
        // Not valid Before Insert because the records have no Ids yet, and therefore can't have any line items.
        // selectNewInvoiceWithLineItemsList (newTriggerValuesMap);
    }
    public override void OnBeforeUpdate (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) 
    {
        doSomethingBeforeUpdate(newTriggerValuesMap);
    }
    
    private static void doSomethingBeforeUpdate (Map<ID, sObject> newTriggerValuesMap)
    {
        for (Invoice__c invoice : selectNewInvoiceWithLineItemsList (newTriggerValuesMap.keySet()))
        {
            for (Line_Item__c lineItem : invoice.Line_Items__r)
            {
                // Do Something
                // If we were to actually do something, we should test it!!!!
            }
        }
        
    }
    
    @TestVisible 
    private static List<Invoice__c> selectNewInvoiceWithLineItemsList (Set<Id> updatedInvoiceIdSet)
    {
        // Perform the SOQL query outside of the for-loop
        // This SOQL query runs once for all items in the Trigger.newMap.KeySet() (a.k.a. newTriggerValuesMap)
        return  [
                        SELECT id, description__c, (SELECT id, quantity__c, merchandise__c FROM Line_Items__r)
                        FROM Invoice__c
                        WHERE id IN :updatedInvoiceIdSet
                ];
                                        
    }

    //------------------------------------------------------------------------------------------------------------------

    public override void OnAfterInsert  (List<sObject> newTriggerValuesList, Map<ID, sObject> newTriggerValuesMap) {}
    
    /**
     * After update integrates to Spring MVC Fulfillment Base
     * @see Integration Workbook, page 10.
     **/ 
    public override void OnAfterUpdate  (List<sObject> oldTriggerValuesList, List<sObject> newTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap, Map<ID, sObject> newTriggerValuesMap) 
    {
        // Cast List and Map to appropriate sObjects and send to required function.
        sendInvoiceListToFulfillmentBase((List<Invoice__c>) newTriggerValuesList, (Map<ID, Invoice__c>) oldTriggerValuesMap);
    }

    private void sendInvoiceListToFulfillmentBase(List<Invoice__c> newTriggerValuesList, Map<ID, Invoice__c> oldTriggerValuesMap)
    {
        // Create an empty list of Ids
        List<Id> invoiceIdList = new List<Id>();
        
        // Iterate through all the *newTrigger* versions of Invoice__c sObjects updated by the call that fires the trigger,
        for (Invoice__c updatedInvoice : newTriggerValuesList)
        {
            // ... adding corresponding Ids to the InvoiceIds list, but *only* when an sObject's status changed from a non-"Closed" value to "Closed".
            if (((updatedInvoice).status__c == 'Closed') &&  ((oldTriggerValuesMap.get(updatedInvoice.Id)) .status__c != 'Closed' )) 
            {
                invoiceIdList.add(updatedInvoice.id);
            }
        }
        
        // If the list of Ids is not empty, call INT_Integration.postOrder supplying the list of Ids for fulfillment.
        if (invoiceIdList.size() > 0) { INT_Integration.postOrder(invoiceIdList); }
    }

    //------------------------------------------------------------------------------------------------------------------

    /**
     * From Executing Data Operations as a Single Transaction
     * @see Apex Workbook, page 51.
     **/ 
    public override void OnBeforeDelete (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) 
    {
        restrictInvoiceDeletion(oldTriggerValuesList, oldTriggerValuesMap);
        // TODO: Write Unit Tests.              
    }

    private void restrictInvoiceDeletion(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap)
    {
        // With each of the invoice statements targeted by the trigger and that have line items,
        // add an error to prevent themn from being deleted.
        for (Invoice__c invoice : [
                                    SELECT id 
                                    FROM Invoice__c 
                                    WHERE (Id IN (SELECT Invoice__c FROM Line_Item__c))
                                        AND (Id IN :oldTriggerValuesList)
                                ])
            {
                oldTriggerValuesMap.get(invoice.id).addError ('Cannot delete invoice statement with line items.');
            }   
    }

    //------------------------------------------------------------------------------------------------------------------
    // Not used yet.
    
    public override void OnAfterDelete  (List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}
    public override void OnAfterUndelete(List<sObject> oldTriggerValuesList, Map<ID, sObject> oldTriggerValuesMap) {}

}