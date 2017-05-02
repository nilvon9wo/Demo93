// @see https://developer.salesforce.com/page/Controller_Component_Communication
public with sharing virtual class COMP_PageControllerBase 
{
	private COMP_ComponentControllerBase componentController;
	public virtual COMP_ComponentControllerBase getComponentController() { return componentController; }
	public virtual void setComponentController(COMP_ComponentControllerBase componentController) { this.componentController = componentController; }
	
	// Enhancements for multi VF component support
	private Map<String, COMP_ComponentControllerBase> componentControllerByKeyMap;
	public virtual Map<String, COMP_ComponentControllerBase> getComponentControllerByStringMap() { return componentControllerByKeyMap; }
	public virtual void setComponentControllerByStringMap(String key, COMP_ComponentControllerBase componentController)
	{
		if (componentControllerByKeyMap == null) { componentControllerByKeyMap = new Map<String, COMP_ComponentControllerBase>(); }
		    componentControllerByKeyMap.put(key, componentController); 
	}
	
	public COMP_PageControllerBase getThis() { return this; }
}