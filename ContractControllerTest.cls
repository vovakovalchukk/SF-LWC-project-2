@isTest
private class ContractControllerTest {

    @testSetup static void setup() {
        // Create common test accounts
        List<Contact> testCons = new List<Contact>();
        for(Integer i = 0; i < 2; i++) {
            Contact c = new Contact(
                FirstName = 'FirstName' + i,
                LastName = 'LastName' + i
            );
            testCons.add(c);
        }
        insert testCons;
    }

    @isTest static void testGetContactsWitnNameFilter() {
       
        List<Contact> testCons = new List<Contact>();
        testCons = ContactController.searchContacts('First');
        System.assertEquals(2, testCons.size(), 'receipted incorrect count of contacts');
    }

    @isTest static void testGetContactsWitnEmptyNameFilter() {
       
        List<Contact> testCons = new List<Contact>();
        testCons = ContactController.searchContacts('');
        System.assertEquals(2, testCons.size(), 'filter works incorrectly');
    }

    @isTest static void testDeleteContacts() {
       
        List<Contact> testCons = new List<Contact>();
        testCons = ContactController.searchContacts('');
        List<String> lstConIds = new List<String>();
        for(Contact con : testCons) {
            lstConIds.add(con.Id);
        }
        ContactController.deleteContacts(lstConIds);
        testCons = ContactController.searchContacts('');
        System.assert(testCons.isEmpty(), 'Not all contacts deleted');
    }

    @isTest static void testDeleteContactsWithError() {
        Boolean exceptionOccurred = false;
        try{
            List<Contact> testCons = new List<Contact>();
            testCons = ContactController.searchContacts('');
            List<String> lstConIds = new List<String>();
            for(Contact con : testCons) {
                lstConIds.add(con.Id);
            }
            ContactController.deleteContacts(lstConIds);
            ContactController.deleteContacts(lstConIds);
            testCons = ContactController.searchContacts('');
        }catch (Exception e){
            exceptionOccurred = true;
        }
       
        System.assert(exceptionOccurred, 'An Exception was not thrown');
    }
}
