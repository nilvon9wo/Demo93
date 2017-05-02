/**
 * Unit Tests for Trigger Handler for Album sObject
 * @author Brian Kessler <brian_kessler@epam.com>
 * @date 2013 August 13
 **/
@isTest
private class MUS_AlbumTriggerHandlerTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
    
	private static void deleteTest(Integer numberOfTracks)
	{
		Album__c dummyAlbum 		  = TEST_DummyAlbumFactory.createDummy(true);
		List<Track__c> dummyTrackList = TEST_DummyTrackFactory.createDummyList(numberOfTracks, new TEST_DummyTrackFactory.Config(dummyAlbum), true); 

		Boolean hadError = false;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
				try { delete dummyAlbum; }
				catch (Exception e) { hadError = true; }            	
            }
            Test.stopTest();
        }
		
		System.assertEquals(numberOfTracks > 0, hadError);
		
		List<Album__c> resultAlbumList = [SELECT id FROM Album__c WHERE id = :dummyAlbum.id LIMIT 1];
		System.assertEquals((numberOfTracks == 0), (resultAlbumList.size() == 0));
	}
	
	public static testMethod void albumHasZeroTracks() { deleteTest(0);  }
	public static testMethod void albumHasOneTrack()   { deleteTest(1);  }
	public static testMethod void albumHasTwoTracks()  { deleteTest(2);  }
	public static testMethod void albumHasTenTracks()  { deleteTest(10); }
	
	// More test methods derived from (but not the same as) Database.com Workbook.-------------------------------------
	// @see Database.com Workbook, page 35
	// @see https://gist.github.com/sbob909/1132449
	
	public static void verifyAlbumDelete(Boolean withTrack)
	{
		// Create test album and insert it.
		Album__c dummyAlbum 		  = TEST_DummyAlbumFactory.createDummyWithTrack(withTrack);
		
		Database.DeleteResult deleteResult = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	// Delete the album, capture the result.
				deleteResult = Database.delete(dummyAlbum, false); 
            }
            Test.stopTest();
        }
        
        // Assert success is opposite of whether album has tracks.
        System.assertEquals ((!withTrack), deleteResult.isSuccess());
	}
	
	public static testMethod void verifyAlbumNoTracksDelete() 			 {verifyAlbumDelete(false);} // Single row album with no tracks => delete
	public static testMethod void verifyAlbumWithTracksRestrictsDelete() {verifyAlbumDelete(true);}  // Single row album with tracks => delete restricted.
	
	// Bult delete of alum: one without tracks; another with
	public static testMethod void verifyBulkAlbumDeleteRestrict()
	{
		// Creates two test albums: one with and one without track
		List<Album__c> dummyAlbumList = new List<Album__c>
			{
				TEST_DummyAlbumFactory.createDummyWithTrack(false),
				TEST_DummyAlbumFactory.createDummyWithTrack(true)
			};

		List<Database.DeleteResult> deleteResultList = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
				// Delete the albums, opt_allOrNone = false, capture the results.
				deleteResultList = Database.delete(dummyAlbumList, false); 
            }
            Test.stopTest();
        }
        
        System.assert(deleteResultList[0].isSuccess()); 	// Assert success for first album [without track]
        System.assert(!deleteResultList[1].isSuccess()); 	// Assert not success for second album [with track]
	}
	
}