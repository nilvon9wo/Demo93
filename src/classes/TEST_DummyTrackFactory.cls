/**
* @description  This class is intended to facilitate creating and populating dummy Tracks for unit testing.*      
* @author       Brian Kessler <Brian_Kessler@epam.com>
* @date         2013 July 18
**/
@isTest 
public class TEST_DummyTrackFactory 
{
    public class Config
    {
    	Album__c	 album		 = null;
    	String 	     name 		 = null;
    	Double       price		 = null;
    	
    	public Config(){}
    	public Config(Album__c album) {this.album = album;}
    }
    
    // Methods for creating one Track -----------------------------------------------------------------------

    /** 
    * @description  Method to create dummy Track for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Track__c
    **/
    public static Track__c createDummy (Config config, Boolean insertNow) 
    {
 	  	TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Album');
 
        Track__c dummyTrack = new Track__c();
                 dummyTrack.name 	 = TEST_ConfigHelper.chooseValue(Config.name,  uniqueHelper.uniqueString);
                 dummyTrack.album__c = TEST_ConfigHelper.chooseValue(Config.album.id, TEST_DummyAlbumFactory.createDummy(true).id);
                 dummyTrack.price__c = TEST_ConfigHelper.chooseValue(Config.price, null); 
        
        if (insertNow) { insert dummyTrack; } 
     	return dummyTrack;
   	}

    /** 
    * @description  Method to create dummy Track for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Track__c
    **/
    public static Track__c createDummy (Boolean insertNow) { return createDummy(new Config(), insertNow); }

    /** 
    * @description  Method to create dummy Track for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       Track__c
    **/
    public static Track__c createDummy()  { return createDummy(false); }
    

    // Methods for creating multiple Tracks -----------------------------------------------------------------------
    
    /** 
    * @description  Method to create dummy Track list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfTracks : How many Tracks to create
    * @param        Config config : Use inner class to configure dummy records.
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Track__c>
    **/
    public static List<Track__c> createDummyList (Integer numberOfTracks, Config config, Boolean insertNow )
    {
        List<Track__c> dummyTrackList = new List<Track__c>();
        for (Integer i=1; i<=numberOfTracks; i++)
        {
            dummyTrackList.add(createDummy(config, false));            
        }
        if (insertNow) { insert dummyTrackList; } 
        return dummyTrackList;
    }
    
    /** 
    * @description  Method to create dummy Track list for testing.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfTracks : How many Tracks to create
    * @param        Boolean insertNow : Whether to insert into SFDC DB now, or wait for latter processing.
    * @return       List<Track__c>
    **/
    public static List<Track__c> createDummyList (Integer numberOfTracks,  Boolean insertNow )
    {
        return createDummyList(numberOfTracks, (new Config()), insertNow); 
    }
    
    /** 
    * @description  Method to create dummy Track list for testing; won't be inserted into SFDC DB at create time.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer numberOfTracks : How many Tracks to create
    * @return       List<Track__c>
    **/
    public static List<Track__c> createDummyList (Integer numberOfTracks) 
    { 
        return createDummyList(numberOfTracks, false); 
    }
}