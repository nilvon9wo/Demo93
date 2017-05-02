/** 
 *	Unit Tests for Uploading an Attachment using Visualforce and a Custom Controller in Salesforce
 *	@see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
@isTest
public class COOK_NotesAttachmentListCntrlExtTest 
{
    public static final User TestRunner = TEST_RunAsUserFactory.create();

	public static testMethod void runTesT()
	{
		Account dummyAccount = TEST_DummyAccountFactory.createDummy(true);

	    Blob 		bodyBlob = Blob.valueOF('Unit Test Attachment Body');
		
		Attachment dummyAttachment = new Attachment();
				   dummyAttachment.Name     = 'Unit Test Attachment';
				   dummyAttachment.body     = bodyBlob;
				   dummyAttachment.parentId = dummyAccount.Id;
				   

		System.runAs(TestRunner)
        {
            Test.startTest();
            {
	   		    insert dummyAttachment;
	   		    
	   		    ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(dummyAccount);
	   		    COOK_NotesAttachmentListCntrlExt controller = new COOK_NotesAttachmentListCntrlExt(sc);
            }
            Test.stopTest();
        }
				   
   		    
				    		
	}
}