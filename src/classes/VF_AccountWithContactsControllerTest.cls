/**
 *	Unit Tests for example of a custom controller.
 *  @see VisualForce Workbook, page 38.
 **/
 @isTest
public class VF_AccountWithContactsControllerTest
{
	public static final User TestRunner = TEST_RunAsUserFactory.create();

	private static Map<Id, List<Contact>> createDummyContactList(List<Account> dummyAccountList)
	{
		Map<Id, List<Contact>> dummyContactMap = new Map<Id, List<Contact>>();
		List<Contact> dummyContactList = new List<Contact>();

		for (Account account : dummyAccountList)
		{
			TEST_DummyContactFactory.Config config = new TEST_DummyContactFactory.Config();
											config.accountId = account.id;
			List<Contact> newDummyContactList = TEST_DummyContactFactory.createDummyList((((Integer) Math.random() * 10) + 1), config, false);
			
			dummyContactMap.put (account.id, newDummyContactList);											
			dummyContactList.addAll(newDummyContactList);
		}	 
		insert dummyContactList;
		return dummyContactMap;
	}

	private static VF_AccountWithContactsController getPageController()
	{
		PageReference pageRef = Page.VF_AccountWithContacts;
		Test.setCurrentPageReference(pageRef);
		VF_AccountWithContactsController pageController = new VF_AccountWithContactsController();
	 						      return pageController;
	}

	public static testMethod void controllerTest()
	{
		List<Account> dummyAccountList = TEST_DummyAccountFactory.createDummyList((((Integer) (Math.random() * 10)) + 1), true);
		Map<Id, List<Contact>> dummyAccountContactMap = createDummyContactList(dummyAccountList);
		
		List<Account> pageAccountList = null;
		Map<Id, List<Contact>> pageAccountContactMap = new Map<Id, List<Contact>>();
        System.runAs(TestRunner)
        {
            Test.startTest();
            {
            	VF_AccountWithContactsController pageController = getPageController();
            	               pageAccountList = pageController.getAccountList();
            	
            	for (Account account : pageAccountList)
            	{
            		pageController.selectedAccountId = account.Id;
            		pageController.accountClicked();
            		List<Contact> selectedContactList = pageController.contactList;
            		pageAccountContactMap.put(account.Id, selectedContactList); 
            	}
            	
            	           
            }
            Test.stopTest();
            
            TEST_DummyAccountFactory.assertEquals(dummyAccountList, pageAccountList);
            TEST_DummyContactFactory.assertEquals(dummyAccountContactMap, pageAccountContactMap);
        }
		
		
	}


}