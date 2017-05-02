/**
* @description  This class is intended to facilitate creating and populating dummy LineItems for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 22
*/
@isTest
public class TEST_DummyLineItemFactory 
{
    public class Config
    {
        public String  name          = null;
    	public Id 	   invoiceId     = null;
    	public Id 	   merchandiseId = null;
        public Double  unitPrice     = null;
        public Integer quantity      = null;
        
        public Config () 			 {}
        public Config (Id invoiceId) { this.invoiceId = invoiceId; }
    }
    
    // Methods for creating one LineItem -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy LineItem for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Line_Item__c
    **/
    public static Line_Item__c createDummy (Config config, Boolean insertNow)
    { 
    	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('LineItem');

    	Id invoiceId     = (config.invoiceId != null) ? config.invoiceId : TEST_dummyInvoiceFactory.createDummy(true).id;

		// Merchandise not required.
    	// Id merchandiseId = (config.merchandiseId != null) ? config.merchandiseId : TEST_dummyMerchandiseFactory.createDummy(true).id;

        Line_Item__c dummyLineItem = new Line_Item__c(); 
                     dummyLineItem.Name           = TEST_ConfigHelper.chooseValue(Config.name, uniqueHelper.uniqueString);  
                     dummyLineItem.Invoice__c     = invoiceid;  
                     dummyLineItem.Merchandise__c = config.merchandiseId;
                     dummyLineItem.Unit_Price__c  = TEST_ConfigHelper.chooseValue(Config.unitPrice, (uniqueHelper.uniqueInt/100));
                     dummyLineItem.Quantity__c    = TEST_ConfigHelper.chooseValue(Config.quantity, uniqueHelper.uniqueInt);
        if (insertNow) { insert dummyLineItem; } 
        return dummyLineItem;
    }

    /** 
    * @description  Method to create dummy LineItem for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Line_Item__c
    **/
    public static Line_Item__c createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy LineItem for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Line_Item__c
    **/
    public static Line_Item__c createDummy()  { return createDummy(false); }
    
    /** 
    * @description  Method to create dummy LineItem for testing
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param		Invoice__c dummyInvoice : dummy Invoice to associate
    * @param		Merchandise__c dummyMerchandise : dummy Merchandise to associate
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Line_Item__c
    **/
    public static Line_Item__c createDummy(Invoice__c dummyInvoice, Merchandise__c dummyMerchandise, Boolean insertNow)
    {
    	Config config = new Config (dummyInvoice.id);
    		   config.merchandiseId = dummyMerchandise.id;
    		   config.unitPrice	    = dummyMerchandise.Price__c;
    		   config.quantity		= (Integer) (10*Math.random()+1);
    		   
    	return createDummy (config, insertNow);
    }

    /** 
    * @description  Method to create dummy LineItem for testing; will be inserted when created.
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param		Invoice__c dummyInvoice : dummy Invoice to associate
    * @param		Merchandise__c dummyMerchandise : dummy Merchandise to associate
    * @return       Line_Item__c
    **/
    public static Line_Item__c createDummy(Invoice__c dummyInvoice, Merchandise__c dummyMerchandise) { return createDummy (dummyInvoice, dummyMerchandise, true); }
    

    // Methods for creating multiple LineItems -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy LineItem list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfLineItems : How many LineItems to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Line_Item__c>
    **/
    public static List<Line_Item__c> createDummyList (Integer numberOfLineItems, Config config, Boolean insertNow )
    {
        List<Line_Item__c> dummyLineItemList = new List<Line_Item__c>();
        for (Integer i=1; i<=numberOfLineItems; i++)
        {
            dummyLineItemList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyLineItemList; } 
        return dummyLineItemList;
    }
    
    /** 
    * @description  Method to create dummy LineItem list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfLineItems : How many LineItems to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Line_Item__c>
    **/
    public static List<Line_Item__c> createDummyList (Integer numberOfLineItems,  Boolean insertNow )
    {
        return createDummyList(numberOfLineItems, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy LineItem list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfLineItems : How many LineItems to create
    * @return       List<Line_Item__c>
    **/
    public static List<Line_Item__c> createDummyList (Integer numberOfLineItems) 
    { 
        return createDummyList(numberOfLineItems, false); 
    }
}