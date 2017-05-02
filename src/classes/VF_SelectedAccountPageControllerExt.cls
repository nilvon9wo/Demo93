/**
 * How to get in a Visualforce page controller a value from a custom component controller?
 * @see http://stackoverflow.com/questions/6103363/how-to-get-in-a-visualforce-page-controller-a-value-from-a-custom-component-cont
 **/
public class VF_SelectedAccountPageControllerExt 
{
	public VF_SelectedAccountPageControllerExt(ApexPages.StandardController controller){}
	public VF_SelectedAccountShell instanceOfSelectedAccount {get; set;}
}