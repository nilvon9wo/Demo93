/**
* @description  This class is intended to facilitate creating and populating dummy Contacts for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 22
*/
@isTest
public class TEST_DummyContactFactory 
{
    public class Config
    {
    	public String  firstName    = null;
        public String  lastName   	= null;
        public String  memberName   = null;
        public Id 	   accountId    = null;
    }
    
    // Methods for creating one Contact -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Contact for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Contact
    **/
    public static Contact createDummy (Config config, Boolean insertNow)
    {
    	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Contact');
    	
        Contact dummyContact = new Contact(); 
                dummyContact.lastName 	    = TEST_ConfigHelper.chooseValue(Config.lastName,   uniqueHelper.uniqueString);
                dummyContact.firstName 	    = TEST_ConfigHelper.chooseValue(Config.firstName,  uniqueHelper.uniqueString);
                dummyContact.member_name__c = TEST_ConfigHelper.chooseValue(Config.memberName, uniqueHelper.uniqueString);
                dummyContact.AccountId		= TEST_ConfigHelper.chooseValue(Config.accountId,  null);
        if (insertNow) { insert dummyContact; } 
        return dummyContact;
    }

    /** 
    * @description  Method to create dummy Contact for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Contact
    **/
    public static Contact createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy Contact for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Contact
    **/
    public static Contact createDummy()  { return createDummy(false); }

    // Methods for creating multiple Contacts -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Contact list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfContacts : How many Contacts to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Contact>
    **/
    public static List<Contact> createDummyList (Integer numberOfContacts, Config config, Boolean insertNow )
    {
        List<Contact> dummyContactList = new List<Contact>();
        for (Integer i=1; i<=numberOfContacts; i++)
        {
            dummyContactList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyContactList; } 
        return dummyContactList;
    }
    
    /** 
    * @description  Method to create dummy Contact list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfContacts : How many Contacts to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Contact>
    **/
    public static List<Contact> createDummyList (Integer numberOfContacts,  Boolean insertNow )
    {
        return createDummyList(numberOfContacts, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Contact list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfContacts : How many Contacts to create
    * @return       List<Contact>
    **/
    public static List<Contact> createDummyList (Integer numberOfContacts) 
    { 
        return createDummyList(numberOfContacts, false); 
    }
 
  	// Assertion Methods --------------------------------------------------------------------------------------------------------------------
    
    /**
     *	@description 	Method to test if two Contact are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 August 07
     *  @param			Contact expectedContact 
     *  @param			Contact actualContact
     *  @return			None
     **/
 	public static void assertEquals (Contact expectedContact, Contact actualContact)
    {
    	System.assertEquals(expectedContact.lastName,	actualContact.lastName);
    	System.assertEquals(expectedContact.firstName,	actualContact.firstName);
    } 

    /**
     *	@description 	Method to test if two Contact Lists are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 August 07
     *  @param			List<Contact> expectedContactList 
     *  @param			List<Contact> actualContactList
     *  @return			None
     **/
 	public static void assertEquals (List<Contact> expectedContactList, List<Contact> actualContactList)
    {
    	System.assertEquals(expectedContactList.size(),		actualContactList.size());
    	expectedContactList.sort();
    	actualContactList.sort();
    	
    	for (Integer i=0; i<expectedContactList.size(); i++)
    	{
    		assertEquals (expectedContactList[i], actualContactList[i]);
    	}
    	
    } 
 
    /**
     *	@description 	Method to test if two Contact Maps are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 August 07
     *  @param			Map<Id, List<Contact>> expectedAccountContactMap 
     *  @param			Map<Id, List<Contact>> actualAccountContactMap
     *  @return			None
     **/
 	public static void assertEquals (Map<Id, List<Contact>> expectedAccountContactMap, Map<Id, List<Contact>> actualAccountContactMap)
    {
    	System.assertEquals(expectedAccountContactMap.keySet().size(), actualAccountContactMap.keySet().size());
    	
    	for (Id id : expectedAccountContactMap.keySet())
    	{
    		System.assert(actualAccountContactMap.keySet().contains(id));
    		assertEquals (expectedAccountContactMap.get(id), actualAccountContactMap.get(id));
    	}
    	
    } 
    
}