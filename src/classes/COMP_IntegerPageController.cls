public with sharing class COMP_IntegerPageController extends COMP_PageControllerBase
{
    public COMP_IntegerComponentController componentController;
     
    public COMP_IntegerComponentController intComponent1Controller 
    { 
        set; 
        get { return getComponentController('component1'); }
    }
    
    public COMP_IntegerComponentController intComponent2Controller 
    { 
        set; 
        get { return getComponentController('component2'); }
    }
    
    private COMP_IntegerComponentController getComponentController(String key)
    {
        // Get the map, then cthe component controller using the appropriate key
        if (getComponentControllerByStringMap() != null)
        {
            COMP_IntegerComponentController intComponentController = (COMP_IntegerComponentController) getComponentControllerByStringMap().get(key);
            if (intComponentController != null) 
            { 
            	return intComponentController; 
            }
        }

		COMP_IntegerComponentController componentController = new COMP_IntegerComponentController();
		setComponentControllerByStringMap(key, componentController);
        
        // Just in case something goes wrong return something... this can be handled better
        return componentController;
    }

    public override void setComponentController(COMP_ComponentControllerBase componentController)
    {
        this.intComponent1Controller = (COMP_IntegerComponentController) componentController;
    }
      
    
    public void setComponent1Controller(COMP_ComponentControllerBase componentController)
    {
        this.intComponent1Controller = (COMP_IntegerComponentController) intComponent1Controller;
        setComponentControllerByStringMap('component1', this.intComponent1Controller);
    }
    
    public void setComponent2Controller(COMP_ComponentControllerBase componentController)
    {
        this.intComponent2Controller = (COMP_IntegerComponentController) intComponent2Controller;
        setComponentControllerByStringMap('component2', this.intComponent2Controller);
    }

    public override COMP_ComponentControllerBase getComponentController() { return intComponent1Controller; }
    
    public COMP_ComponentControllerBase getComponent1ControllerMethod() { return intComponent1Controller; }

    public PageReference callComponentControllerMethod()  { return callComponent1ControllerMethod();        }
    public PageReference callComponent1ControllerMethod() { return incrementValue(intComponent1Controller); }
    public PageReference callComponent2ControllerMethod() { return incrementValue(intComponent2Controller); }
    
    private PageReference incrementValue(COMP_IntegerComponentController intComponentController )
    {
        intComponentController.incrementIntValue();
        return null;
    }
}