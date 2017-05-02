/**
 *	 Unit Tests to retrieve a List of Objects using Apex
 *	 @see http://developer.force.com/cookbook/recipe/retrieve-a-list-of-objects-using-apex
 *   @see http://boards.developerforce.com/t5/Apex-Code-Development/File-Attachment-Unit-Test-Help/td-p/166241
 *   @see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
 @isTest
private class COOK_RetrieveListOfSObjectsPageCtrlTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();
    
    private static testMethod void getObjectOptionListTest()
    {
		List<SelectOption> optionList = null;
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	COOK_RetrieveListOfSObjectsPageCtrl controller = new COOK_RetrieveListOfSObjectsPageCtrl();
            				           optionList = controller.getObjectOptionsList();
            }
            Test.stopTest();
        }
	
		objectOptionAssert(optionList);
    }
    
    private static void objectOptionAssert(List<SelectOption> optionList)
    {
    	List<String> objectLabelList = COOK_RetrieveListOfSObjectsPageCtrl.getSortedObjectLabelList();  

    	List<String> optionLabelList = new List<String>();
    	List<String> optionValueList = new List<String>();

		for (SelectOption option : optionList)
		{
			optionLabelList.add(option.getLabel());
			optionValueList.add(option.getValue());
		}

    	objectLabelList.sort();
    	optionLabelList.sort();
    	optionValueList.sort();
		
		Integer i = 0;
		for (String objectLabel : objectLabelList)
		{
			System.assertEquals(objectLabel, optionLabelList[i], optionValueList[i]);
			i++;
		}
		    							 
    } 
	
}