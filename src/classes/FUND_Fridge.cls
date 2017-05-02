/**
 * Fridge Example
 * @see Apex Workbook, page 25.
 **/
public class FUND_Fridge implements FUND_KitchenUtilityInterface  
{
    public static final Integer DEFAULT_STOCK_THRESHOLD = 5;

    private static Integer stockThreshold = DEFAULT_STOCK_THRESHOLD;
    public  static void setStockThreshold(Integer threshold) { stockThreshold = threshold; }
    public  static Integer getStockThreshold() { return stockThreshold; } 
    
    private String modelNumber;
    public  void setModelNumber(String modelNumber) { this.modelNumber = modelNumber; }
    public  String getModelNumber() { return this.modelNumber; }    
    
    private Integer numberInStock;
    public  Integer getNumberInStock() { return this.numberInStock; }    
    
    public Integer ecoRating
    {
    	get { return ecoRating; }
    	set { ecoRating = value; if (ecoRating < 0) ecoRating = 0; }
    }
    
    public FUND_Fridge (String modelNumber, Integer numberInStock)
    {
        this.modelNumber   = modelNumber;
        this.numberInStock = numberInStock; 
    }

    public FUND_Fridge () { this('XX-XX', 0); }
    
    public void updateStock (Integer justSold)
    {
        numberInStock = numberInStock - justSold;
    }
    
    public static void toDebug (FUND_Fridge fridge)
    {
        System.debug(LoggingLevel.INFO, fridge.modelNumber);
        System.debug(LoggingLevel.INFO, fridge.numberInStock);
    }
    
}