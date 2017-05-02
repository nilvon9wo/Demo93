/**
 *	Example of a custom controller.
 *  @see VisualForce Workbook, page 38.
 **/
public class VF_AccountWithContactsController 
{
	public Id 			 selectedAccountId 		 { get; set; }
	public List<Contact> contactList 			 { get; set; } 

	public List<Account> getAccountList()
	{
		return [
					SELECT id, name, accountNumber
					FROM Account
					ORDER BY LastModifiedDate DESC
					LIMIT 10
			];
	}
	
	public void accountClicked()
	{
		contactList = [
					SELECT firstName, lastName
					FROM Contact
					WHERE accountId = :selectedAccountId
			];
	}
	
	
}