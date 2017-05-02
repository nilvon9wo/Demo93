/**
 *	Uploading a Document using Visualforce and a Custom Controller
 *  @see http://developer.force.com/cookbook/recipe/uploading-a-document-using-visualforce-and-a-custom-controller
 **/
public with sharing class COOK_UploadDocUsingVFPageController 
{
	public Document document
	{
		get
		{
				   document = (document == null) ? (new Document()) : document;
			return document;
		}
		set;
	}
	
	public PageReference upload()
	{
		document.AuthorId = UserInfo.getUserId();
		document.FolderId = UserInfo.getUserId();  		// put it in running user's default Personal folder.
		
		if (document.body != null)
		{
			try { insert document; }
			catch (DMLException e)
			{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Error uploading file'));
				return null;
			}
			finally
			{
				document.body = null; 						// Clears the viewstate
				document	  = new Document();
			}

			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO, 'File uploaded successfully'));

		}
		else
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'File is missing.'));
		}		
		
		return null;
	}
	
	
}