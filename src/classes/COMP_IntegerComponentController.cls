public with sharing class COMP_IntegerComponentController extends COMP_ComponentControllerBase
{
	private Integer intValue = 3;
	public  Integer getIntValue() { return intValue; }
	public  void    incrementIntValue() 
	{ 
		intValue++; 
	}
}