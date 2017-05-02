/**
 * Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
public with sharing virtual class VF_PageControllerBase 
{
	public VF_PageControllerBase getThis() { return this; }	

	private VF_ComponentControllerBase componentController;
	public virtual VF_ComponentControllerBase getComponentController() { return this.componentController; }
	public virtual void setComponentController(VF_ComponentControllerBase componentController) { this.componentController = componentController; }

	// Extends to support multiple VisualForce components on a single VF Page. 
	private Map<String, VF_ComponentControllerBase> componentControllerMap; 
	public virtual Map<String, VF_ComponentControllerBase> getComponentControllerMap() {return this.componentControllerMap;}
	public virtual void setComponentControllerMap (String key, VF_ComponentControllerBase componentController)
	{
		if (componentControllerMap == null)  { componentControllerMap = new Map<String, VF_ComponentControllerBase>(); }
		componentControllerMap.put(key, componentController);
	}

	
}