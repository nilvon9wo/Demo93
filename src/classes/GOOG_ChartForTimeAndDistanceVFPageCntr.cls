/**
 * This class contains an example of using the encoding algorithm for use with the Google chart API.
 **/
public class GOOG_ChartForTimeAndDistanceVFPageCntr 
{

	// Semi-public variables
	public  String 					dataSetString  		{ get; 		   set; }	// Corresponds to the data set provided by the page.
	public  String 					graphString  		{ get; 		   set; }	// Corresponds to the type of graph selected on the page.
	public  String 					chartURL  			{ get; 		   set; }	// The URL that renders the Google Chart.
	public  Boolean 				displayChart		{ get; 		   set; }	// Indicates whether the chart should be displayed.

	private GOOG_GoogleDataEncoding dataEncoding;
	
	public GOOG_ChartForTimeAndDistanceVFPageCntr()
	{
		this.displayChart = false;
		this.dataEncoding = new GOOG_GoogleDataEncoding(GOOG_GoogleDataEncoding.EncodingType.SIMPLE);
	}

	public PageReference create()
	{
		String[] dataSetArray = dataSetString.split(',', 0);
		String   mappedValue  = 'chd='+ dataEncoding.getEncodingDescriptor() +':';
		
		this.chartURL 		  = 'http://chart.apis.google.com/chart?chs=600x300'
									+ '&amp;chtt=Time+vs|Distance&amp;chxt=x,y,x,y' 
				         			+ '&amp;chxr=0,0,10,1|1,0,65,5'
				         			+ '&amp;chxl=2:|Seconds|3:|Meters'
				         			+ '&amp;cht=' + dataEncoding.getEncodedChart(graphString);

        for (String dataPoint : dataSetArray) { mappedValue += dataEncoding.getEncode(Integer.valueOf(dataPoint.trim())); }    
         
        this.chartURL += '&amp;' + mappedValue;
        this.displayChart = true;
        return null;
	}

}