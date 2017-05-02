/**
 * Unit Tests for examples of Apex Rest
 * @see Apex Workbook, page 69.
 **/
@isTest
private class REST_MerchandiseManagerTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static testMethod void testGetMerchandiseId()
	{
		Merchandise__c dummyMerchandise = TEST_DummyMerchandiseFactory.createDummy(true);

		RestRequest request  = new RestRequest();
					request.requestURI = 'https://na15.salesforce.com/services/apexrest/v.9/Merchandise/'+ dummyMerchandise.id;
					request.httpMethod = 'GET';
		RestResponse response = new RestResponse();
		RestContext.request = request;												// pass the request and response objects to the method
		RestContext.response = response;

		Merchandise__c resultMerchandise = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                resultMerchandise = REST_MerchandiseManager.getMerchandiseById();
            }
            Test.stopTest();
        }
		
		TEST_DummyMerchandiseFactory.assertEquals (dummyMerchandise, resultMerchandise);
	}

	private static testMethod void testCreateMerchandise()
	{
		TEST_UniqueHelper unique = new TEST_UniqueHelper('Http Post Merchandise');
		String  name 		 = unique.uniqueString;
		String  description  = name + 'Description';
		Decimal price		 = unique.uniqueInt/100;
		Double  inventory	 = unique.uniqueInt;

		Id newMerchandiseId = null;
		
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
                newMerchandiseId = REST_MerchandiseManager.createMerchandise(name, description, price, inventory);
            }
            Test.stopTest();
        }

		Merchandise__c selectedmerchandise = [SELECT name, description__c, price__c, quantity__c FROM Merchandise__c WHERE id = :newMerchandiseId];
		
		System.assertEquals(name, 		 selectedmerchandise.name);
		System.assertEquals(description, selectedmerchandise.description__c);
		System.assertEquals(price, 		 selectedmerchandise.price__c);
		System.assertEquals(inventory, 	 selectedmerchandise.quantity__c);
	}

}