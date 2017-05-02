/** 
 *	Uploading an Attachment using Visualforce and a Custom Controller in Salesforce
 *	@see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
public class COOK_NotesAttachmentListCntrlExt 
{
	public  List<Attachment> 			attachmentList 		{set; get;}
	public  List<Account>    			allAccountList 		{set; get;}
	public  List<COOK_AttachmentModel>  attachmentModelList {set; get;}
	public  Integer 					serialNumber 		{set; get;}
	
	private	Account account;
	
	public COOK_NotesAttachmentListCntrlExt (ApexPages.StandardController sc)
	{
		account 		= (Account) sc.getRecord();
		allAccountList  = [SELECT id, name FROM Account WHERE id = :account.id];
		attachmentList  = [
							SELECT id, name, ContentType, OwnerId, ParentId
							FROM Attachment
							WHERE ParentId = :account.id
						  ];

				serialNumber = 0;
		Integer i			 = 0;
		
		attachmentModelList = new List<COOK_AttachmentModel>();
		for (Attachment attachment : attachmentList)
		{
			COOK_AttachmentModel    attachmentModel = new COOK_AttachmentModel();
								    attachmentModel.serialNumber = ++i;
								    attachmentModel.attachment   = attachment;
			attachmentModelList.add(attachmentModel);	 
		}
		
	}
}