/**
 *	Example Visualforce Pages with Apex Controllers
 *  @See Apex Workbook, page 73 
 **/
public class WARE_MerchandiseCatalogVFPageController 
{
	@TestVisible List<WARE_DisplayMerchandise> merchandiseList; 
	public List<WARE_DisplayMerchandise> getMerchandiseList()
	{
		if (merchandiseList == null) 
		{ 
			merchandiseList = new List<WARE_DisplayMerchandise>();
			for (Merchandise__c merchandise : [SELECT id, name, description__c, price__c, quantity__c FROM Merchandise__c])
			{
				merchandiseList.add(new WARE_DisplayMerchandise(merchandise));
			} 
		}
		return merchandiseList;
	}
	
	// Shopping Cart ---------------------------------------------------------------------------
	
	@TestVisible List<WARE_DisplayMerchandise> shoppingCartList = new List<WARE_DisplayMerchandise>();
	
	// Action method to handle purchasing process
	public PageReference addToCart()
	{
		Map<id,WARE_DisplayMerchandise> merchandiseMap  = WARE_DisplayMerchandise.buildMap (merchandiseList); 
		Map<id,WARE_DisplayMerchandise> shoppingCartMap = WARE_DisplayMerchandise.buildMap (shoppingCartList);  
		
		for (Id merchandiseId : merchandiseMap.keySet())
		{
			if (
					(merchandiseMap.get(merchandiseId).quantityToBuy != 0)
						&& 
					(merchandiseMap.get(merchandiseId).quantityToBuy != null) 
				) 
			{ 
				shoppingCartMap.put (merchandiseId, merchandiseMap.get(merchandiseId)); 
			}
			else 												 	  { shoppingCartMap.remove (merchandiseId); }
		}
		
		shoppingCartList = shoppingCartMap.values();
		return null; // stay on the same page
	} 
	
	public String getCartContents()
	{
		if (0 == shoppingCartList.size()) { return '(empty)'; }
		
		String  message = '<ul>\n';

			for (WARE_DisplayMerchandise merchandise : shoppingCartList)
			{
					message += '<li>';
						message += merchandise.name + ' (' +  merchandise.quantityToBuy + ')';
					message += '</li>\n';
			}

				message += '</ul>\n';

		 return message;
	}
	
}