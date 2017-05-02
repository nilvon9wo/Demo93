/**
* @description  This class is intended to facilitate creating and populating dummy Albums for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 18
*/
@isTest
public class TEST_DummyAlbumFactory  
{
    public class Config
    {
    	String name 		= null;
    	String description 	= null;
    	Date   releasedOn 	= null;
    	
    	public Config(){}
    	public Config(String name) {this.name = name;}
    }
    
    // Methods for creating one Album -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Album for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @param		Boolean withTrack : Whether to create AND INSERT a track for the invoice at this time. (Expected to fail if insertNow is not also true.)
    * @return       Album__c
    **/
    public static Album__c createDummy (Config config, Boolean insertNow, Boolean withTrack) 
    {
    	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Album');
    	
        Album__c dummyAlbum = new Album__c();
                 dummyAlbum.name 		   = TEST_ConfigHelper.chooseValue(Config.name, uniqueHelper.uniqueString);
                 dummyAlbum.description__c = TEST_ConfigHelper.chooseValue(Config.description, uniqueHelper.uniqueString + ' description');
                 dummyAlbum.Released_On__c = TEST_ConfigHelper.chooseValue(Config.releasedOn, date.newInstance(1960, 02, 17)); 
                 
        if (insertNow) 
        { 
        	insert dummyAlbum;
        	if (withTrack) { TEST_DummyTrackFactory.createDummy(new TEST_DummyTrackFactory.Config(dummyAlbum), true );} 
        } 
        
     	return dummyAlbum;
   	}

    /** 
    * @description  Method to create dummy Album for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Album__c
    **/
    public static Album__c createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow, false); }

    /** 
    * @description  Method to create dummy Album for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Album__c
    **/
    public static Album__c createDummy()  { return createDummy(false); }


    /** 
    * @description  Method to create dummy Album with Track Item for testing.
    * @see Database.com Workbook, page 35.
    * @see https://gist.github.com/sbob909/1132449
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 13
    * @param		Boolean withTrack : Whether to create AND INSERT a track for the invoice at this time. (Expected to fail if insertNow is not also true.)
    * @return       Invoice__c
    **/
    // Unfortunately, needs different name to distinquish from createDummy (Boolean insertNow)
    public static Album__c createDummyWithTrack (Boolean withTrack) { return createDummy(new Config(), true, withTrack); }


    // Methods for creating multiple Albums -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Album list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfAlbums : How many Albums to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Album__c>
    **/
    public static List<Album__c> createDummyList (Integer numberOfAlbums, Config config, Boolean insertNow )
    {
        List<Album__c> dummyAlbumList = new List<Album__c>();
        for (Integer i=1; i<=numberOfAlbums; i++)
        {
            dummyAlbumList.add(createDummy(config, false, false));            
        }
        if (insertNow) { insert dummyAlbumList; } 
        return dummyAlbumList;
    }
    
    /** 
    * @description  Method to create dummy Album list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfAlbums : How many Albums to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Album__c>
    **/
    public static List<Album__c> createDummyList (Integer numberOfAlbums,  Boolean insertNow )
    {
        return createDummyList(numberOfAlbums, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Album list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfAlbums : How many Albums to create
    * @return       List<Album__c>
    **/
    public static List<Album__c> createDummyList (Integer numberOfAlbums) 
    { 
        return createDummyList(numberOfAlbums, false); 
    }
}