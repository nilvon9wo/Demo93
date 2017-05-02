/**
 * This class contains an example of using the encoding algorithm for use with the Google chart API.
 **/
@isTest
public class GOOG_ChartForTimeAndDistanceVFPgCntrTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static GOOG_ChartForTimeAndDistanceVFPageCntr getPageController(String dataSetString, String graphString)
	{
		PageReference pageRef = Page.GOOG_ChartForTimeAndDistance;
		Test.setCurrentPageReference(pageRef);
		GOOG_ChartForTimeAndDistanceVFPageCntr pageController = new GOOG_ChartForTimeAndDistanceVFPageCntr();
											   pageController.dataSetString = dataSetString;
											   pageController.graphString   = graphString;
  								        return pageController;
	}

	private static void createTest (String dataSetString, String graphString)
	{
		GOOG_ChartForTimeAndDistanceVFPageCntr pageController = getPageController(dataSetString, graphString);
		Boolean encodingExceptionCaught = false;
	
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
				try { pageController.create(); }
				catch (GOOG_EncodingException e) { encodingExceptionCaught = true; }
            }
            Test.stopTest();
        }

		Map<String,String> chartMap = new Map<String,String>
		{
			'barChart'  => 'bvs',
			'lineChart' => 'ls'
		};
		
		if (chartMap.keySet().contains(graphString))
		{
			String chartURL = pageController.chartURL;
			System.assert(chartURL.contains('cht=' + chartMap.get(graphString)));

			System.assert(pageController.displayChart);
			
		}
		else { System.assert(encodingExceptionCaught); }
	}		

	private static testMethod void createBarChartTest()   { createTest('1,2,3,4,5', 'barChart'); }
	private static testMethod void createLineChartTest()  { createTest('1,2,3,4,5', 'lineChart'); }
	private static testMethod void createOtherChartTest() { createTest('1,2,3,4,5', 'otherChart'); }

	
}