/**
 * Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
public with sharing class VF_PageControllerImplemented extends VF_PageControllerBase 
{
	public VF_ComponentControllerImplemented component1Controller { set; get { return this.getController('component1'); } }
	public VF_ComponentControllerImplemented component2Controller { set; get { return this.getController('component2'); } }
	
	private VF_ComponentControllerImplemented getController (String key)
	{
		VF_ComponentControllerImplemented controller = null;
		
		// get the map, then the component controller using the appropriate key
		if (getComponentControllerMap() != null) { controller  = (VF_ComponentControllerImplemented) getComponentControllerMap().get(key); }
		
		// just in case something goes wrong return something... this can be handled better
		return (controller != null) ? controller :  (new VF_ComponentControllerImplemented());
	}
	
	public PageReference callComponent1ControllerMethod()  { this.component1Controller.incrementValue(); return null; }
	public PageReference callComponent2ControllerMethod()  { this.component2Controller.incrementValue(); return null; }
}