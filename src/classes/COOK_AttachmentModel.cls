/** 
 *	Uploading an Attachment using Visualforce and a Custom Controller in Salesforce
 *	@see http://cloudisfuture.blogspot.hu/2012/04/upload-file-as-attachment-to-record.html
 **/
public class COOK_AttachmentModel 
{
	public Integer    serialNumber  {get;set;}
	public Attachment attachment	{get;set;}
	
	public COOK_AttachmentModel()
	{
		serialNumber = 0;
		attachment = new Attachment();
	}
}