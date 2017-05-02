/**
 * Controller Component Communication
 * @see http://wiki.developerforce.com/page/Controller_Component_Communication
 **/
public with sharing class VF_ComponentControllerImplemented extends VF_ComponentControllerBase
{
	private Integer intValue = 3;
	public Integer getIntValue() { return this.intValue;   }
	public void incrementValue() {        this.intValue++; }
}