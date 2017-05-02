/**
 *	Unit Tests for Once-Inner class to hold online store details for each merchandise item.  
 * 	(Moved to seperate class because I prefer shorter classes and code reuse.)
 *  Example Visualforce Pages with Apex Controllers
 *  @See Apex Workbook, page 73 
 **/
 @isTest
public class WARE_DisplayMerchandiseTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static testMethod void buildMapTest()
	{
		List<Merchandise__c> merchandiseList = TEST_DummyMerchandiseFactory.createDummyList(10, true);
		List<WARE_DisplayMerchandise> displayMerchandiseList = createDummyList (merchandiseList);
		
		Map<id,WARE_DisplayMerchandise> displayMerchandiseMap = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                 displayMerchandiseMap = WARE_DisplayMerchandise.buildMap (displayMerchandiseList);
            }
            Test.stopTest();
        }

		assertEquivalent (merchandiseList, displayMerchandiseMap);
	}

	public static List<WARE_DisplayMerchandise> createDummyList(List<Merchandise__c> merchandiseList)
	{
		List<WARE_DisplayMerchandise> displayMerchandiseList = new List<WARE_DisplayMerchandise>();
		for (Merchandise__c merchandise : merchandiseList) { displayMerchandiseList.add(new WARE_DisplayMerchandise(merchandise)); }
		return displayMerchandiseList;
	}

	public static List<WARE_DisplayMerchandise> createDummyList()
	{
		List<Merchandise__c> merchandiseList = TEST_DummyMerchandiseFactory.createDummyList(10, true);
		return createDummyList (TEST_DummyMerchandiseFactory.createDummyList(10, true));
	}
	
	public static void assertEquivalent (List<Merchandise__c> merchandiseList, Map<id,WARE_DisplayMerchandise> displayMerchandiseMap)
	{
		for (Merchandise__c merchandise : merchandiseList)
		{
			WARE_DisplayMerchandise displayMerchandise = displayMerchandiseMap.get(merchandise.id);

			System.assertEquals (merchandise.name, 			 	 displayMerchandise.name		);
			System.assertEquals (merchandise.description__c, 	 displayMerchandise.description	);
			System.assertEquals (merchandise.price__c, 		 	 displayMerchandise.price		);
			System.assertEquals ((merchandise.quantity__c > 0),	 displayMerchandise.inStock		);
		}		 
	}
	
}