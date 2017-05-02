public with sharing virtual class COMP_ComponentControllerBase 
{
    private String key
    {
        get;
        set
        {
            if (value != null)
            {
                key = value;
                if (pageController != null) { pageController.setComponentControllerByStringMap(key,this); }
            }
        }   
    }
    public void setKey(String value)
    {
        if (value != null)
        {
            key = value;
            if (pageController != null) { pageController.setComponentControllerByStringMap(key,this); }
        }
    }

    public COMP_PageControllerBase pageController 
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
}