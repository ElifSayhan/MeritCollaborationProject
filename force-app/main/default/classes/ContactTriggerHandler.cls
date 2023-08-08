public class ContactTriggerHandler {
    public static void accountActiveContacts(List<Contact> contactList) {
        Set<Id> accountIds = new Set<Id>();
        for (Contact con : contactList) {
            if (String.isNotBlank(con.AccountId)) {
                accountIds.add(con.AccountId);
            }
        }

        List<Account> accList = [SELECT Id,Active_Contacts__c, 
                                 (SELECT Id FROM Contacts WHERE Active__c = true) 
                                 FROM Account 
                                 WHERE Id IN :accountIds];

        for (Account acc : accList) {
            if (!acc.Contacts.isEmpty()) {
                acc.Active_Contacts__c = acc.Contacts.size();
            } else {
                acc.Active_Contacts__c = 0;
            }
        }
        update accList;
    }

    public static void updateActiveContacts(List<Contact> newContacts, Map<Id, Contact> oldMap) {
        Set<Id> accountIds = new Set<Id>();

        for (Contact con : newContacts) {
            if (con.Active__c != oldMap.get(con.Id).Active__c || con.AccountId != oldMap.get(con.Id).AccountId) {
                if (String.isNotBlank(con.AccountId)) {
                    accountIds.add(con.AccountId);
                    accountIds.add(oldMap.get(con.Id).AccountId);
                }
            }
        }

        if (!accountIds.isEmpty()) {
            List<Account> accList = [SELECT Id,Active_Contacts__c, 
                                     (SELECT Id FROM Contacts WHERE Active__c = true) 
                                     FROM Account 
                                     WHERE Id IN :accountIds];

            for (Account acc : accList) {
                 acc.Active_Contacts__c = acc.Contacts.size();
            }
            update accList;
        }
    }
}