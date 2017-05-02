/**
* @description  This class is intended to facilitate creating and populating dummy Accounts for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 22
*/
@isTest
public class TEST_DummyAccountFactory 
{
    public class Config
    {
        public String  name   = null;
        
        public Config (){}
        public Config (String name) { this.name = name; }
    }
    
    // Methods for creating one Account -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Account for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Account
    **/
    public static Account createDummy (Config config, Boolean insertNow)
    {
    	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Account');
    	
        Account dummyAccount = new Account(); 
                   dummyAccount.name = TEST_ConfigHelper.chooseValue(Config.name, uniqueHelper.uniqueString);
        if (insertNow) { insert dummyAccount; } 
        return dummyAccount;
    }

    /** 
    * @description  Method to create dummy Account for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Account
    **/
    public static Account createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy Account for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Account
    **/
    public static Account createDummy()  { return createDummy(false); }

    // Methods for creating multiple Accounts -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Account list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Integer numberOfAccounts : How many Accounts to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Account>
    **/
    public static List<Account> createDummyList (Integer numberOfAccounts, Config config, Boolean insertNow )
    {
        List<Account> dummyAccountList = new List<Account>();
        for (Integer i=1; i<=numberOfAccounts; i++)
        {
            dummyAccountList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyAccountList; } 
        return dummyAccountList;
    }
    
    /** 
    * @description  Method to create dummy Account list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Integer numberOfAccounts : How many Accounts to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Account>
    **/
    public static List<Account> createDummyList (Integer numberOfAccounts,  Boolean insertNow )
    {
        return createDummyList(numberOfAccounts, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Account list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 07
    * @param        Integer numberOfAccounts : How many Accounts to create
    * @return       List<Account>
    **/
    public static List<Account> createDummyList (Integer numberOfAccounts) 
    { 
        return createDummyList(numberOfAccounts, false); 
    }

 	// Assertion Methods --------------------------------------------------------------------------------------------------------------------
    
    /**
     *	@description 	Method to test if two Account are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 August 07
     *  @param			Account expectedAccount 
     *  @param			Account actualAccount
     *  @return			None
     **/
 	public static void assertEquals (Account expectedAccount, Account actualAccount)
    {
    	System.assertEquals(expectedAccount.id,		actualAccount.id);
    	System.assertEquals(expectedAccount.name,	actualAccount.name);
    } 

    /**
     *	@description 	Method to test if two Account Lists are the same
     *	@author 		Brian Kessler <Brian_Kessler@epam.com>
     *	@date			2013 August 07
     *  @param			List<Account> expectedAccountList 
     *  @param			List<Account> actualAccountList
     *  @return			None
     **/
 	public static void assertEquals (List<Account> expectedAccountList, List<Account> actualAccountList)
    {
    	System.assertEquals(expectedAccountList.size(),		actualAccountList.size());
    	expectedAccountList.sort();
    	actualAccountList.sort();
    	
    	for (Integer i=0; i<expectedAccountList.size(); i++)
    	{
    		assertEquals (expectedAccountList[i], actualAccountList[i]);
    	}
    	
    } 


 	



    
    
}