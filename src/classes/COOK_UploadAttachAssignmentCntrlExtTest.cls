/** 
 *	Unit Tests for Uploading an Attachment using Visualforce and a Custom Controller in Salesforce
 *	@see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
 @isTest
public class COOK_UploadAttachAssignmentCntrlExtTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static void doUploadTest(Boolean hasName, Boolean hasBody, Boolean successExpected)
	{
		Account dummyAccount = TEST_DummyAccountFactory.createDummy(true); 

        String fileName = (hasName) ? (new TEST_UniqueHelper('Dummy Attachment')).uniqueString : null;
        Blob fileBody = (hasBody) ? Blob.valueOf('Unit Test Attachment Body') : null;
				
		COOK_UploadAttachmentAssignmentCntrlExt ext = null; 
		System.runAs(TestRunner)
        {
            Test.startTest();
            {
	   		    ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(dummyAccount);
	   		    
				ext = new COOK_UploadAttachmentAssignmentCntrlExt(sc);
				ext.fileName = fileName;
				ext.fileBody = fileBody;
				ext.uploadFile();

            }
            Test.stopTest();

            System.assertEquals (successExpected, ext.isSaved);
        }
		
	}	

	public static testMethod void uploadSuccessTest()    { doUploadTest ( true,  true,  true  ); }
	public static testMethod void noNameUploadFailTest() { doUploadTest ( false, true,  false ); }
	public static testMethod void noBodyUploadFailTest() { doUploadTest ( true,  false, false ); }

}