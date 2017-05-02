/**
 *	Example of a controller Extension.
 *  @see VisualForce Workbook, page 36.
 **/
public class VF_AccountControllerExtension 
{
	@TestVisible private final Account account;
	
	public VF_AccountControllerExtension(ApexPages.StandardController controller)
	{
		this.account = (Account) controller.getRecord();
	}
	
	public String getTitle() { return 'Account: ' + account.name + ' (' + account.id + ')'; }
}