/**
 *	Unit Tests for Uploading a Document using Visualforce and a Custom Controller
 *  @see http://developer.force.com/cookbook/recipe/uploading-a-document-using-visualforce-and-a-custom-controller
 **/
 @isTest
private class COOK_UploadDocUsingVFPageControllerTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static void doUploadTest(Boolean hasName, Boolean hasBody, Boolean successExpected)
	{
		TEST_UniqueHelper uniqueHelper = new TEST_UniqueHelper('Dummy Document');
		
		Document dummyDocument = new Document();
            	 dummyDocument.name = (hasName) ? uniqueHelper.uniqueString : null;
            	 dummyDocument.body = (hasBody) ? Blob.valueOf('Unit Test Document Body') : null;
            	 
        PageReference pageRef = Page.COOK_UploadDocUsingVF;
        Test.setCurrentPage(pageRef);
        //ApexPages.currentPage().getParameters().put('id', testObj.id);
				 
		ApexPages.Message[] pageMessageArray = null;
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	COOK_UploadDocUsingVFPageController controller = new COOK_UploadDocUsingVFPageController();
            										controller.document = dummyDocument;
													controller.upload();

				pageMessageArray = ApexPages.getMessages();
            }
            Test.stopTest();

            System.assert (pageMessageArray[0].getSeverity() == (successExpected ? ApexPages.severity.INFO : ApexPages.severity.ERROR));
            
        }
		
	}	

	public static testMethod void uploadSuccessTest()    { doUploadTest ( true,  true,  true  ); }
	public static testMethod void noNameUploadFailTest() { doUploadTest ( false, true,  false ); }
	public static testMethod void noBodyUploadFailTest() { doUploadTest ( true,  false, false ); } // TODO: Resolve why this test fails!
	

}