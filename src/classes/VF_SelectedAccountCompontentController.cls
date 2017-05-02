/**
 * How to get in a Visualforce page controller a value from a custom component controller?
 * @see http://stackoverflow.com/questions/6103363/how-to-get-in-a-visualforce-page-controller-a-value-from-a-custom-component-cont
 **/
public class VF_SelectedAccountCompontentController 
{
	public void VF_SelectedAccountCompontentController(){}

	public VF_SelectedAccountShell selectedAccountShell {get; set;}
	
	public PageReference selectAccountFromUI (Account selectedAccount)
	{
		this.selectedAccountShell.account = selectedAccount;
		return null;
	}	
	
}