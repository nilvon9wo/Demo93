/**
 * Examples of Apex Rest
 * @see Apex Workbook, page 69.
 **/
@RestResource (urlMapping='/Merchandise/*')
global with sharing class REST_MerchandiseManager 
{
	@HttpGet
	global static Merchandise__c getMerchandiseById()
	{
		RestRequest request  = RestContext.request;
		String merchandiseId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
		Merchandise__c result = [SELECT name, description__c, price__c, quantity__c FROM Merchandise__c WHERE id = :merchandiseId];
			    return result;
	}
	
	@HttpPost
	global static String createMerchandise (String name, String description, Decimal price, Double inventory)
	{
		Merchandise__c merchandise = new Merchandise__c (
												name 			= name,
												description__c  = description,
												price__c		= price,
												quantity__c		= inventory
											);
				insert merchandise;
			    return merchandise.id;
	}
}