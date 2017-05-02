/**
 * Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
public with sharing virtual class VF_ComponentControllerBase 
{
	public VF_PageControllerBase pageController 
	{ 	
		get;
		set
		{
			if (value != null)
			{
				pageController = value;
				pageController.setComponentController(this);
			}
		}
	}

	// Extends to support multiple VisualForce components on a single VF Page.
	public String key
	{
		get;
		set
		{
			if (value != null)
			{
				key = value;
				if (pageController != null) { pageController.setComponentControllerMap(Key, this); }
			}
		}
	}

}