public class TEST_AbstractDummyFactory 
{
	public static SObject create (Map<String,Map<String,Object>> valueByFieldNameByTypeMap, SObject originalSObject, TEST_DummyInsertModeEnum insertMode)
	{
		SObject newSObject = originalSObject.clone();
		
		List<String> fieldTypeList = new List<String>{ 'String', 'Boolean' }; 
		
		for (String fieldType : fieldTypeList)
		{
			if (valueByFieldNameByTypeMap.containsKey(fieldType))
			{
				Map<String,Object> valueByFieldNameMap = valueByFieldNameByTypeMap.get(fieldType);
				for (String fieldName : valueByFieldNameMap.keySet())
				{
					if      (fieldType == 'String')  { newSObject.put(fieldName, (String)  valueByFieldNameMap.get(fieldName)); } 
					else if (fieldType == 'Boolean') { newSObject.put(fieldName, (Boolean) valueByFieldNameMap.get(fieldName)); }
				}  
			}
		}

		// TODO: Implement insert/mock-insert
				
		return newSObject;
	}	
}