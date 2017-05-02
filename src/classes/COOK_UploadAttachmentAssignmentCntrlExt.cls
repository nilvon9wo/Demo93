/** 
 *	Uploading an Attachment using Visualforce and a Custom Controller in Salesforce
 *	@see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
public class COOK_UploadAttachmentAssignmentCntrlExt 
{
	public Id 			recordId 	{get; set;}
	public String		fileName	{get; set;}
	public Blob			fileBody	{get; set;}
	public Boolean		isSaved		{get; set;}
	// public Attachment	attachment	{get; set;}

	public COOK_UploadAttachmentAssignmentCntrlExt(ApexPages.StandardController controller)
	{
		this.recordId 	= controller.getRecord().id;
		this.isSaved	= false; 
	}
	
	public PageReference UploadFile()
	{
		if ((this.fileName != null) && (this.fileBody != null))
		{
			Attachment attachment = new Attachment();
					   attachment.Name 		= this.fileName;
					   attachment.Body 		= this.fileBody;
					   attachment.ParentId	= this.recordId;
				insert attachment;
				
			this.isSaved = true;
		}
		
		return null;
	}
}