/**
 * Unit Test for example of using Apex code in a Cloud Flow process.
 * @see Cloud Flow Designer Workbook, page 29.
 * @see https://gist.github.com/2422564
 **/
 @isTest
private class MORT_MortgageCalculatorFlowProcessTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
	
	public static testMethod void testAll()
	{
		Double dummyAmount = 500000;
		Double dummyTerm   = 360;
		Double dummyRate   = 5;

		Process.PluginRequest request = setInputParameters (dummyAmount, dummyTerm, dummyRate);

		Double actualMonthlyPayment    			 = null;
		Process.PluginDescribeResult description = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
					MORT_MortgageCalculatorFlowProcess                 calculatorPlugin = new MORT_MortgageCalculatorFlowProcess();
					Process.PluginResult 			calculatorResult = calculatorPlugin.invoke(request);
					actualMonthlyPayment = (Double) calculatorResult.outputParameters.get('MonthlyPayment');
					
					description      	 							 = calculatorPlugin.describe();
            }
            Test.stopTest();
        }
		
		assertRate (dummyAmount, dummyTerm, dummyRate, actualMonthlyPayment);		
		assertDescription (description);
	}
	
	private static Process.PluginRequest setInputParameters (Double dummyAmount, Double dummyTerm, Double dummyRate)
	{
		Map<String, Object> 			 inputParameters = new Map<String, Object>();
										 inputParameters.put ('Amount', dummyAmount);
										 inputParameters.put ('Term',   dummyTerm);
										 inputParameters.put ('Rate',   dummyRate);
		return new Process.PluginRequest(inputParameters);
	}

	private static void assertRate(Double dummyAmount, Double dummyTerm, Double dummyRate, Double actualMonthlyPayment)
	{
		Double dummyMonthlyRate      = dummyRate/1200; 
		Double expectedMontlyPayment = Math.roundToLong(dummyAmount * (dummyMonthlyRate/(1 - Math.pow(1 + dummyMonthlyRate, -dummyTerm))));
		System.assertEquals(expectedMontlyPayment, Math.roundToLong(actualmonthlyPayment));
	}
	
	private static void assertDescription(Process.PluginDescribeResult description)
	{
		System.assertEquals(3       		     , description.InputParameters.size());
		System.assertEquals('Amount'		     , description.InputParameters[0].name);
		System.assertEquals('Term'  		     , description.InputParameters[1].name);
		System.assertEquals('Rate'  		     , description.InputParameters[2].name);
		
		System.assertEquals(1       		     , description.OutputParameters.size());
		System.assertEquals('MonthlyPayment'     , description.OutputParameters[0].name);
	}
	
}