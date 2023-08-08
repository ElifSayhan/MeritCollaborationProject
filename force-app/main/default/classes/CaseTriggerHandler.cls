public class CaseTriggerHandler {
    public static void updateCaseWithParentId(list<Case> newCases){
        Set<Id> SetAccount = new Set<Id>();
        list<Case> listCases = new list<Case>();
        Map<Id, list<case>> accountToCase = new Map<Id, list<case>>();
        
        for(Case c : newCases){
            if(c.AccountId != null){
               SetAccount.add(c.AccountId) ;
                
            }
        }
        list<Account> listAccount = [SELECT Id,(SELECT Origin, ParentId, AccountId FROM Cases ORDER BY CreatedDate DESC) FROM Account WHERE Id IN :SetAccount];
        
        for(Account a :listAccount){
            accountToCase.put(a.Id,a.Cases);
        }
        for(Case c: newCases){
            if(c.AccountId !=null){
                
                for(Case oldCase : accountToCase.get(c.AccountId)){
                    if((c.Origin == oldCase.Origin) && (c.Id !=oldCase.Id)) {
                        c.ParentId =oldCase.Id;
                        listCases.add(c);
                        break;
                    }
                }
            }
        }
    }
}