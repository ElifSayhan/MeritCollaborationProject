public class AccountTriggerHandler {
    public static void handleOpportunityCreation(List<Account> accounts){
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        
        for(Account account : accounts){
            if(account.Opportunities == null || account.Opportunities.isEmpty()) {
                Opportunity opportunity = new Opportunity();
                opportunity.Name = account.Name + 'Opportunity';
                opportunity.StageName = 'Prospecting';
                opportunity.CloseDate = System.today().addMonths(1);
                opportunity.AccountId = account.Id;
                
                opportunitiesToInsert.add(opportunity);
            }
        }
        
        if(!opportunitiesToInsert.isEmpty()){
            insert opportunitiesToInsert;
        }
    }
}

/* 2.Method

public class AccountTriggerHandler {
    
      public static void insertOpp(List<Account> newAccs){
       
      Set<Id> accIds = new Set<Id>();
      for(Account acc : newAccs){
          accIds.add(acc.Id);
      }

      List<Account> accList = [SELECT Id, Name, (SELECT Id FROM Opportunities) 
                              FROM Account WHERE Id IN: accIds];
    if(accList.Opportunity.isEmpty()){

    }
    
    List<Opportunity> oppList = new List<Opportunity>();

    for(Account acc : accList){
           
                opportunity.Name = account.Name + 'Opportunity';
                opportunity.StageName = 'Prospecting';
                opportunity.CloseDate = System.today().addMonths(1);
                opportunity.AccountId = account.Id;

    }
    insert oppList;
  }
}

*/