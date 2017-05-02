/**
 * Unit Tests for Fridge Example
 * @see Apex Workbook, page 25.
 **/
@isTest
private class FUND_FridgeTest 
{

    private static testmethod void testDefaultConstructor()
    {
        FUND_Fridge fridge = new FUND_Fridge();
        System.assertEquals ('XX-XX', fridge.getModelNumber());
        System.assertEquals (0, fridge.getNumberInStock()); 
    }
    
    private static testmethod void testGetModelNumber()
    {
        String modelNumber = 'MX-EO';
        FUND_Fridge fridge = new FUND_Fridge(modelNumber, 0);
        System.assertEquals (modelNumber, fridge.getModelNumber());
    }
    
    private static testmethod void testSetModelNumber()
    {
        FUND_Fridge fridge = new FUND_Fridge();
        String modelNumber = 'MX-EO';
        fridge.setModelNumber(modelNumber);
        System.assertEquals (modelNumber, fridge.getModelNumber());
    }
    
    private static testmethod void testThreshold()
    {
        System.assertEquals (FUND_Fridge.DEFAULT_STOCK_THRESHOLD, FUND_Fridge.getStockThreshold()); 
        Integer newThreshold = 4;
        FUND_Fridge.setStockThreshold(newThreshold);
        System.assertEquals(newThreshold, FUND_Fridge.getStockThreshold());
        
    }

	private static void testEchoRating(Integer rating)
	{
		FUND_Fridge fridge = new FUND_Fridge();
					fridge.ecoRating = rating;
		System.assertEquals (
								(
									(rating >= 0)
										? rating
										: 0
								), 
								fridge.ecoRating
		);						
	}
	
	private static testmethod void testPostiveRating()  { testEchoRating(10);  }
	private static testmethod void testZeroRating()     { testEchoRating(0);  }
	private static testmethod void testNegativeRating() { testEchoRating(-5); }

    private static testmethod void twoFridgeTest()
    {

        Integer fridgeOneStock        = 100;
        Integer fridgeOneSold         = 20;
        FUND_Fridge fridge1 = new FUND_Fridge('MX-O', fridgeOneStock);
                    fridge1.updateStock(20); 
               
        Integer fridgeTwoStock         = 50;
        FUND_Fridge fridge2 = new FUND_Fridge('MX-Y', fridgeTwoStock);

        System.assertEquals ((fridgeOneStock - fridgeOneSold), fridge1.getNumberInStock()); 
        System.assertEquals (fridgeTwoStock, fridge2.getNumberInStock());
    }
    
    private static testmethod void testDebug()
    {
        FUND_Fridge fridge = new FUND_Fridge();
        FUND_Fridge.toDebug(fridge);            
    }
}