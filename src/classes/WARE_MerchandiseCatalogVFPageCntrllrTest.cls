/**
 *	Unit Tests for Example Visualforce Pages with Apex Controllers
 *  @See Apex Workbook, page 73 
 **/
@isTest
private class WARE_MerchandiseCatalogVFPageCntrllrTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static WARE_MerchandiseCatalogVFPageController getPageController(List<WARE_DisplayMerchandise> merchandiseList, List<WARE_DisplayMerchandise> shoppingCartList)
	{
		PageReference pageRef = Page.WARE_MerchandiseCatalog;
		Test.setCurrentPageReference(pageRef);
		WARE_MerchandiseCatalogVFPageController pageController = new WARE_MerchandiseCatalogVFPageController();
												pageController.merchandiseList  = merchandiseList;
												pageController.shoppingCartList = shoppingCartList;
									     return pageController;
	}

	private static WARE_MerchandiseCatalogVFPageController getPageController(List<Merchandise__c> dummyMerchandiseList, Integer numberOfCartContents)
	{
		List<WARE_DisplayMerchandise> displayMerchandiseList   = WARE_DisplayMerchandiseTest.createDummyList(dummyMerchandiseList);

		List<WARE_DisplayMerchandise> shoppingCartList	       = new List<WARE_DisplayMerchandise>();
		for (Integer i=1; i<=numberOfCartContents; i++) 
		{ 
			displayMerchandiseList[i-1].quantityToBuy = 1;
			shoppingCartList.add(new WARE_DisplayMerchandise(dummyMerchandiseList[i-1]));
			shoppingCartList[i-1].quantityToBuy = 1;
		}

		return getPageController(displayMerchandiseList, shoppingCartList);
	}

	private static testMethod void getMerchandiseListTest()    
	{ 
		WARE_MerchandiseCatalogVFPageController pageController = getPageController((List<WARE_DisplayMerchandise>) null, (List<WARE_DisplayMerchandise>) null);

		List<Merchandise__c> dummyMerchandiseList = TEST_DummyMerchandiseFactory.createDummyList(10, true);
		
		Map<id,WARE_DisplayMerchandise> displayMerchandiseMap = null;
		
		System.runAs(TestRunner)
    	{
		    Test.startTest();
		    {
				for (Integer i = 0; i <= 1; i++) // First iteration tests when list is null; second iteration tests when list exists.
				{
						displayMerchandiseMap = WARE_DisplayMerchandise.buildMap (pageController.getMerchandiseList());
	    	    }
				WARE_DisplayMerchandiseTest.assertEquivalent (dummyMerchandiseList, displayMerchandiseMap);
            }
            Test.stopTest();
		}
	}
	
	private static String getShoppingCartContents(WARE_MerchandiseCatalogVFPageController pageController)
	{
		String shoppingCartContents = null;
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
				shoppingCartContents = pageController.getCartContents();
            }
            Test.stopTest();
        }
		return shoppingCartContents;		
	}
	
	private static testMethod void getShoppingCartListWhenNoneTest()   
	{ 
		List<WARE_DisplayMerchandise> displayMerchandiseList   = WARE_DisplayMerchandiseTest.createDummyList();
		WARE_MerchandiseCatalogVFPageController pageController = getPageController(displayMerchandiseList, new List<WARE_DisplayMerchandise>());

		String shoppingCartContents = getShoppingCartContents(pageController);
        System.assertEquals('(empty)', shoppingCartContents);
	}
	
	private static void getShoppingCartListWhenExistsTest(Integer numberOfMerchandise, Integer numberOfCartContents) 
	{ 
		List<Merchandise__c> dummyMerchandiseList 			   = TEST_DummyMerchandiseFactory.createDummyList(numberOfMerchandise, true);
		WARE_MerchandiseCatalogVFPageController pageController = getPageController(dummyMerchandiseList, numberOfCartContents);
		String shoppingCartContents = getShoppingCartContents(pageController);
		
		Integer contentCount = 0;
		for (Integer j=1; j<=numberOfCartContents; j++)
		{
			System.assert(shoppingCartContents.contains(dummyMerchandiseList[j-1].Name));
		}
	}
	
	private static testMethod void getShoppingCartWithOneItemOfOneTest()  { getShoppingCartListWhenExistsTest(1 , 1);  }
	private static testMethod void getShoppingCartWithOneItemOfTenTest()  { getShoppingCartListWhenExistsTest(10, 1);  }
	private static testMethod void getShoppingCartWithTwoItemsOfTenTest() { getShoppingCartListWhenExistsTest(10, 2);  }
	private static testMethod void getShoppingCartWithTenItemsOfTenTest() { getShoppingCartListWhenExistsTest(10, 10); }
	
	private static void addToShoppingCartListTest(Integer numberOfMerchandise, Integer numberOfCartContents, Integer numberOfItemsToAdd) 			
	{
		List<Merchandise__c> dummyMerchandiseList 			   = TEST_DummyMerchandiseFactory.createDummyList(numberOfMerchandise, true);
		WARE_MerchandiseCatalogVFPageController pageController = getPageController(dummyMerchandiseList, numberOfCartContents);
		
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
				for (Integer i=1; i<=numberOfItemsToAdd; i++) 
				{
					pageController.merchandiseList[(numberOfCartContents + i - 1)].quantityToBuy = 1;
				}

				pageController.addToCart();
            }
            Test.stopTest();
        }
		
		List<Merchandise__c> expectedMerchandiseList = buildExpectedMerchandiseList (dummyMerchandiseList, (numberOfCartContents + numberOfItemsToAdd));
		WARE_DisplayMerchandiseTest.assertEquivalent (expectedMerchandiseList, WARE_DisplayMerchandise.buildMap (pageController.shoppingCartList));
	}
	
	private static testMethod void addOneToShoppingCartWithNoneItemOfOneTest()   { addToShoppingCartListTest(1 , 0,  1);  }
	private static testMethod void addOneToShoppingCartWithNoneItemOfTenTest()   { addToShoppingCartListTest(10, 0,  1);  }
	private static testMethod void addTwooShoppingCartWithOneItemOfTenTest()     { addToShoppingCartListTest(10, 1,  2);  }
	private static testMethod void addFiveToShoppingCartWithTwoItemsOfTenTest()  { addToShoppingCartListTest(10, 2,  5);  }
	private static testMethod void addOneTohoppingCartWithNineItemsOfTenTest()   { addToShoppingCartListTest(10, 9,  1);  }

	private static void removeFromShoppingCartListTest(Integer numberOfMerchandise, Integer numberOfCartContents, Integer numberOfItemsToRemove) 			
	{
		List<Merchandise__c> dummyMerchandiseList 			   = TEST_DummyMerchandiseFactory.createDummyList(numberOfMerchandise, true);
		WARE_MerchandiseCatalogVFPageController pageController = getPageController(dummyMerchandiseList, numberOfCartContents);
		
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
				for (Integer i=numberOfItemsToRemove; i>=1; i--) 
				{
					pageController.merchandiseList[(numberOfCartContents - i)].quantityToBuy = 0;
				}

				pageController.addToCart();
            }
            Test.stopTest();
        }
		
		if (numberOfCartContents > numberOfItemsToRemove)
		{
			List<Merchandise__c> expectedMerchandiseList = buildExpectedMerchandiseList (dummyMerchandiseList, (numberOfCartContents - numberOfItemsToRemove));
			WARE_DisplayMerchandiseTest.assertEquivalent (expectedMerchandiseList, WARE_DisplayMerchandise.buildMap (pageController.shoppingCartList));
		}
		else { System.assertEquals('(empty)', pageController.getCartContents()); }
	}

	private static testMethod void removeOneFromShoppingCartWithOneItemOfOneTest()     { removeFromShoppingCartListTest(1 , 1,  1);  }
	private static testMethod void removeOneFromShoppingCartWithOneItemOfTenTest()     { removeFromShoppingCartListTest(10, 1,  1);  }
	private static testMethod void removeTwoFromShoppingCartWithFiveItemOfTenTest()    { removeFromShoppingCartListTest(10, 5,  2);  }
	private static testMethod void removeFiveFromShoppingCartWithSevenItemsOfTenTest() { removeFromShoppingCartListTest(10, 7,  5);  }
	private static testMethod void removeOneTohoppingCartWithNineItemsOfTenTest()      { removeFromShoppingCartListTest(10, 9,  1);  }
	
	private static List<Merchandise__c> buildExpectedMerchandiseList (List<Merchandise__c> dummyMerchandiseList, Integer numberOfCartContents)
	{
		List<Merchandise__c> expectedMerchandiseList = new List<Merchandise__c>();
		for (Integer i=1; i<=numberOfCartContents; i++)
		{
			expectedMerchandiseList.add (dummyMerchandiseList[i-1]);
		} 
		return expectedMerchandiseList; 
	}

}