/**
 *	 Retrieve a List of Objects using Apex
 *	 @see http://developer.force.com/cookbook/recipe/retrieve-a-list-of-objects-using-apex
 **/
public class COOK_RetrieveListOfSObjectsPageCtrl 
{
	public String value {get; set;}
	
	public List<SelectOption> getObjectOptionsList()
	{
		List<String> objectLabelList  = getSortedObjectLabelList();
		List<SelectOption> optionList = new List<SelectOption>();
		
		for (String objectLabel : objectLabelList)
		{
			optionList.add(new SelectOption(objectLabel, objectLabel));
		}
				
		return optionList;
	}
	
	@testVisible private static List<String> getSortedObjectLabelList()
	{
		List<Schema.SObjectType> globalDescriptionList = Schema.getGlobalDescribe().Values();
		
    	List<String> objectLabelList = new List<String>();
		for (Schema.SObjectType objectType : globalDescriptionList)
		{
    		objectLabelList.add(objectType.getDescribe().getLabel());
		}
		
		objectLabelList.sort();
		return objectLabelList;
	}
	

	
}