/**
 * Unit Tests for Exception Handling example
 **/
@isTest
public class WARE_MerchandiseUtilityTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static void doMainProcess(Merchandise__c merchandise)
	{
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                WARE_MerchandiseUtility.mainProcessing(merchandise); 
            }
            Test.stopTest();
        }
	}

	private static testmethod void testValidInsert()
	{
		TEST_DummyMerchandiseFactory.Config config = new TEST_DummyMerchandiseFactory.Config();
											config.name = 'Valid Test Merchandise' + TEST_UniqueHelper.random();
		
		Merchandise__c merchandise = TEST_DummyMerchandiseFactory.createDummy(config, false);
		
		doMainProcess(merchandise);

		List<Merchandise__c> merchandiseList = [SELECT id FROM Merchandise__c WHERE name = :config.name];
		System.assertEquals(1, merchandiseList.size());
	}
	
	private static testmethod void testInvalidInsert()
	{
		Merchandise__c merchandise = new Merchandise__c();
					   merchandise.Name = 'Invalid Test Merchandise' + TEST_UniqueHelper.random();
		
		doMainProcess(merchandise);

		List<Merchandise__c> merchandiseList = [SELECT id FROM Merchandise__c WHERE name = :merchandise.Name];
		System.assertEquals(0, merchandiseList.size());
	}
		
	
}