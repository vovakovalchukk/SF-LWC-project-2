public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm) {
        
        searchTerm = '%' + searchTerm.trim() + '%';

        return [
            SELECT FirstName, LastName, Email, Account.Name, MobilePhone, CreatedDate
            FROM Contact
            WHERE Name LIKE :searchTerm
            WITH SECURITY_ENFORCED
            LIMIT 50
        ];
    }

    @AuraEnabled
    public static void deleteContacts(list<Id> lstConIds) {
        try {
            list<Contact> contactsToDelete = new list<Contact>();
            for(Id idCon : lstConIds) {
                contactsToDelete.add(new Contact(Id = idCon));
            }
            if(!contactsToDelete.isEmpty()) {
                delete contactsToDelete;
            }
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}
