/**
* @description  This class is intended to facilitate creating and populating dummy Merchandises for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 22
*/
@isTest
public class TEST_DummyMerchandiseFactory 
{
    public class Config
    {
        public String  name         = null;
        public String  description  = null;
        public Double  price        = null;
        public Integer quantity     = null;
        
        public Config () 				{}
        public Config (String name)	{ this.name = name; }
    }
    
    // Methods for creating one Merchandise -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Merchandise for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Merchandise__c
    **/
    public static Merchandise__c createDummy (Config config, Boolean insertNow)
    {
    	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Merchandise');
    	
        Merchandise__c dummyMerchandise = new Merchandise__c(); 
                   dummyMerchandise.Name           = TEST_ConfigHelper.chooseValue(Config.name, uniqueHelper.uniqueString);  
                   dummyMerchandise.Price__c       = TEST_ConfigHelper.chooseValue(Config.price, (uniqueHelper.uniqueInt/100));
                   dummyMerchandise.Quantity__c    = TEST_ConfigHelper.chooseValue(Config.quantity, uniqueHelper.uniqueInt);
                   dummyMerchandise.Description__c = TEST_ConfigHelper.chooseValue(Config.description, 'Description of ' + uniqueHelper.uniqueString);
        if (insertNow) { insert dummyMerchandise; } 
        return dummyMerchandise;
    }

    /** 
    * @description  Method to create dummy Merchandise for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Merchandise__c
    **/
    public static Merchandise__c createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy Merchandise for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Merchandise__c
    **/
    public static Merchandise__c createDummy()  { return createDummy(false); }
    
    /** 
    * @description  Method to create dummy Merchandise for testing
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param        String merchandiseName : name for merchandise
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Merchandise__c
    **/
	public static Merchandise__c createDummy (String merchandiseName, Boolean insertNow)
	{
		Config config = new Config (merchandiseName);
			   config.description = 'Fresh juice';
			   config.price       = 2;
			   config.quantity    = 1000;
	
		return createDummy (config, insertNow);
	}    
	
    /** 
    * @description  Method to create dummy Merchandise for testing; will insert immediately
    * @see Apex Workbook, page 53.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 23
    * @param        String merchandiseName : name for merchandise
    * @return       Merchandise__c
    **/
	public static Merchandise__c createDummy (String merchandiseName) { return createDummy (merchandiseName, true); }
	

    // Methods for creating multiple Merchandises -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Merchandise list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfMerchandises : How many Merchandises to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Merchandise__c>
    **/
    public static List<Merchandise__c> createDummyList (Integer numberOfMerchandises, Config config, Boolean insertNow )
    {
        List<Merchandise__c> dummyMerchandiseList = new List<Merchandise__c>();
        for (Integer i=1; i<=numberOfMerchandises; i++)
        {
            dummyMerchandiseList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyMerchandiseList; } 
        return dummyMerchandiseList;
    }
    
    /** 
    * @description  Method to create dummy Merchandise list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfMerchandises : How many Merchandises to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Merchandise__c>
    **/
    public static List<Merchandise__c> createDummyList (Integer numberOfMerchandises,  Boolean insertNow )
    {
        return createDummyList(numberOfMerchandises, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Merchandise list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfMerchandises : How many Merchandises to create
    * @return       List<Merchandise__c>
    **/
    public static List<Merchandise__c> createDummyList (Integer numberOfMerchandises) 
    { 
        return createDummyList(numberOfMerchandises, false); 
    }
    
    // Methods to test Merchandise [still/already] exists in database ---------------------------------------------------------------
    
    /**
     *	@description 	Method to test Merchandise [still/already] exists in database
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 July 24
     *  @param			List<Merchandise__c> merchandiseList : List of merchandise to look for.
     *  @param			Boolean expected	: Whether the system should expect to find all of them.
     *  @return			None
     **/
	public static void assertMerchandise (List<Merchandise__c> merchandiseList, Boolean expected)
	{
        Integer merchandiseCount = [SELECT count() FROM Merchandise__c WHERE id IN :merchandiseList ];
        System.assertEquals(((expected)?merchandiseList.size():0), merchandiseCount);
	} 

    /**
     *	@description 	Method to test Merchandise [still/already] exists in database
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 July 24
     *  @param			String merchandiseName : Name of merchandise to look for.
     *  @param			Boolean expected	: Whether the system should expect to find one of them.
     *  @return			None
     **/
 	public static void assertMerchandise (String merchandiseName, Boolean expected)
    {
         Integer merchandiseCount = [ SELECT count() FROM Merchandise__c WHERE Name = :merchandiseName ];
         System.assertEquals((expected)?1:0, merchandiseCount);
    } 

    /**
     *	@description 	Method to test if two Merchandise__c are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 July 24
     *  @param			Merchandise__c expectedMerchandise 
     *  @param			Merchandise__c actualMerchandise
     *  @return			None
     **/
 	public static void assertEquals (Merchandise__c expectedMerchandise, Merchandise__c actualMerchandise)
    {
    	System.assertEquals(expectedMerchandise.name,				actualMerchandise.name);
    	System.assertEquals(expectedMerchandise.description__c,		actualMerchandise.description__c);
    	System.assertEquals(expectedMerchandise.price__c,			actualMerchandise.price__c);
    	System.assertEquals(expectedMerchandise.quantity__c,		actualMerchandise.quantity__c);
    } 


 	
 	// Debug Methods --------------------------------------------------------------------------------------------------------------------
 	
    /**
     *	@description 	Method to debug Merchandise which may still exists in database when not expected
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 July 24
     *  @param			List<Merchandise__c> merchandiseList : List of merchandise to look for.
     *  @return			None
     **/
     public static void debug (List<Merchandise__c> merchandiseList)
     {
     	displayList('merchandiseList', merchandiseList);

     	List<Merchandise__c> selectedMerchandiseList = [ SELECT id, name FROM Merchandise__c WHERE id IN :merchandiseList ]; 
     	displayList('selectedMerchandiseList', selectedMerchandiseList);

     	List<Line_Item__c> selectedLineItemList = [ SELECT id, merchandise__c FROM Line_Item__c WHERE merchandise__c IN :selectedMerchandiseList ];
     	displayList('selectedLineItemList', selectedLineItemList);
     }
     
     private static void displayList(String listName, List<sObject> sObjectList)
     {
     	System.debug(LoggingLevel.INFO, ' $$$$$$ ' + listName + ' : ' + sObjectList.size());
     	System.debug(LoggingLevel.INFO, ' $$$$$$ ' + listName + ' : ' + sObjectList);
     }
 	   
    /**
     *	@description 	Method to debug Merchandise which may still exists in database when not expected
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 July 24
     *  @param			Merchandise__c merchandise : Merchandise to look for.
     *  @return			None
     **/
     public static void debug (Merchandise__c merchandise)
     {
     	debug (new List<Merchandise__c>{merchandise});
     }

    
    
}