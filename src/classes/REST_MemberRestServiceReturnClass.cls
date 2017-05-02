/**
 * Writing Unit Tests for v24 Apex REST Services
 * @see http://blog.jeffdouglas.com/2012/03/21/writing-unit-tests-for-v24-apex-rest-services/
 **/
global class REST_MemberRestServiceReturnClass 
{
	global String success;
	global String message;
	global List<Contact> contactList;
	
	global REST_MemberRestServiceReturnClass (String success, String message, List<Contact> contactList)
	{
		this.success 		= success;
		this.message 		= message;
		this.contactList	= contactList;
	}
}