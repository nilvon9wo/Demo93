/**
 * Accessing Custom Component Attributes in a Controller
 * @see http://www.salesforce.com/us/developer/docs/pages/Content/pages_comp_cust_elements_controllers.htm
 **/
public class VF_CustomComponentController 
{
	public String controllerValue;
	public void setControllerValue (String controllerValue) { this.controllerValue = controllerValue.toUpperCase(); }
	public String getControllerValue() { return this.controllerValue; }
	
}