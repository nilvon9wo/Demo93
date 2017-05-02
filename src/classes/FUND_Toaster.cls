/**
 * Interface Example
 * @see Apex Workbook, page 29.
 **/
public class FUND_Toaster implements FUND_KitchenUtilityInterface  
{
	private String modelNumber;
	public String getModelNumber() { return 'T' + this.modelNumber; }
}