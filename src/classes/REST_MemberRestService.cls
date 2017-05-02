/**
 * Writing Unit Tests for v24 Apex REST Services
 * @see http://blog.jeffdouglas.com/2012/03/21/writing-unit-tests-for-v24-apex-rest-services/
 **/
 @RestResource (urlMapping = '/v.9/member/*/results/*') 
global with sharing class REST_MemberRestService 
{
	@HttpGet
	global static REST_MemberRestServiceReturnClass doGet()
	{
		String[] uriKeysArray = RestContext.request.requestURI.split('/');
		String memberName = uriKeysArray.get(uriKeysArray.size()-3); 		// Get the member name from the uri
		
		List <Contact> contactList = null;
		// do awesome programming stuff here and catch any exceptions
		try 
		{ 
			contactList = [ SELECT id FROM Contact WHERE member_name__c = :memberName ];
			if (Test.isRunningTest() && (memberName == 'ThrowException')) { throw new REST_MemberRestServiceException('Exception Test'); }				 
		}
 		catch (Exception e) { return new REST_MemberRestServiceReturnClass ('false', e.getMessage(), null); }

   		return new REST_MemberRestServiceReturnClass('true', 'Query executed successfully.', contactList);
	}
}