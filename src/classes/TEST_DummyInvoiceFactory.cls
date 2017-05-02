/**
* @description  This class is intended to facilitate creating and populating dummy Invoices for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 18
*/
@isTest
public class TEST_DummyInvoiceFactory 
{
    public class Config
    {
        public String status  = null;
        public String orderId = null;
    }
    
    // Methods for creating one Invoice -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Invoice with Line Item for testing.
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @param		Boolean withLineItem : Whether to create AND INSERT a line item for the invoice at this time. (Expected to fail if insertNow is not also true.)
    * @return       Invoice__c
    **/
    public static Invoice__c createDummy (Config config, Boolean insertNow, Boolean withLineItem)
    {
        Invoice__c dummyInvoice = new Invoice__c();
                   dummyInvoice.Status__c  = TEST_ConfigHelper.chooseValue(Config.status, 'Open');  
                   dummyInvoice.OrderId__c = TEST_ConfigHelper.chooseValue(Config.orderId, '');
        if (insertNow) { insert dummyInvoice; } 
    	
    	if (withLineItem == true)  // This probably won't work if InsertNow is not also true.
    	{
    		Merchandise__c dummyMerchandise = TEST_DummyMerchandiseFactory.createDummy ('Orange juice');	// Creates and inserts merchandise item
    		TEST_DummyLineItemFactory.createDummy(dummyInvoice, dummyMerchandise);							// Create one Line Item and associate it with the invoice statement.
    	}
 
     	return dummyInvoice;
    }


    /** 
    * @description  Method to create dummy Invoice for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Invoice__c
    **/
    public static Invoice__c createDummy (Config config, Boolean insertNow) { return createDummy (config, insertNow, false); }

    /** 
    * @description  Method to create dummy Invoice for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Invoice__c
    **/
    public static Invoice__c createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy Invoice for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Invoice__c
    **/
    public static Invoice__c createDummy()  { return createDummy(false); }
    
    /** 
    * @description  Method to create dummy Invoice with Line Item for testing.
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param		Boolean withLineItem : Whether to create AND INSERT a line item for the invoice at this time. (Expected to fail if insertNow is not also true.)
    * @return       Invoice__c
    **/
    // Unfortunately, needs different name to distinquish from createDummy (Boolean insertNow)
    public static Invoice__c createDummyWithLineItem (Boolean withLineItem) { return createDummy(new Config(), true, withLineItem); }


    // Methods for creating multiple Invoices -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Invoice list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfInvoices : How many Invoices to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Invoice__c>
    **/
    public static List<Invoice__c> createDummyList (Integer numberOfInvoices, Config config, Boolean insertNow )
    {
        List<Invoice__c> dummyInvoiceList = new List<Invoice__c>();
        for (Integer i=1; i<=numberOfInvoices; i++)
        {
            dummyInvoiceList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyInvoiceList; } 
        return dummyInvoiceList;
    }
    
    /** 
    * @description  Method to create dummy Invoice list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfInvoices : How many Invoices to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Invoice__c>
    **/
    public static List<Invoice__c> createDummyList (Integer numberOfInvoices,  Boolean insertNow )
    {
        return createDummyList(numberOfInvoices, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Invoice list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfInvoices : How many Invoices to create
    * @return       List<Invoice__c>
    **/
    public static List<Invoice__c> createDummyList (Integer numberOfInvoices) 
    { 
        return createDummyList(numberOfInvoices, false); 
    }
}