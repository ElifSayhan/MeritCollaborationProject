trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    switch on Trigger.operationType {
        when AFTER_INSERT {
            ContactTriggerHandler.accountActiveContacts(Trigger.new);
        }
        when AFTER_UNDELETE {
            ContactTriggerHandler.accountActiveContacts(Trigger.new);
        }
        when AFTER_DELETE {
            ContactTriggerHandler.accountActiveContacts(Trigger.old);
        }
        when AFTER_UPDATE {
            ContactTriggerHandler.updateActiveContacts(Trigger.new, Trigger.oldMap);
        }
    }
}