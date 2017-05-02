/**
 *	Once-Inner class to hold online store details for each merchandise item.  
 * 	(Moved to seperate class because I prefer shorter classes and code reuse.)
 *  Example Visualforce Pages with Apex Controllers
 *  @See Apex Workbook, page 73 
 **/
public class WARE_DisplayMerchandise 
{
	// Properties for use in the VisualForce view
	public String  name 	     { get { return merchandise.name; 		       } }
	public String  description   { get { return merchandise.description__c;    } }
	public Decimal price         { get { return merchandise.price__c; 	       } }
	public Boolean inStock	   	 { get { return (0 < merchandise.quantity__c); } }
	public Integer quantityToBuy { get; set; }

	private Merchandise__c merchandise;
	
	public WARE_DisplayMerchandise(Merchandise__c merchandise) { this.merchandise = merchandise; }

	public static Map<id,WARE_DisplayMerchandise> buildMap (List<WARE_DisplayMerchandise> displayMerchandiseList)
	{
		Map<id,WARE_DisplayMerchandise> merchandiseMap = new Map<id,WARE_DisplayMerchandise>(); 
		
		for (WARE_DisplayMerchandise displayMerchandise : displayMerchandiseList)
		{
			merchandiseMap.put(displayMerchandise.merchandise.id, displayMerchandise);
		}
		
		return merchandiseMap;
	}	
}