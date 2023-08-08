public class OpportunityTriggerHandler {
     
    public static void updateNewTaskForCWonOpp(List<Opportunity> oppList, Map<Id, Opportunity> oppOldMap){
       List<Task> taskList = new List<Task>();
        
        for(Opportunity w :oppList){
            if(w.StageName == 'Closed Won' && oppOldMap.get(w.Id).StageName != 'Closed Won'){
                Task newT = new Task(Subject = 'Follow up Task',
                                     WhatId=w.Id,
                                     OwnerId=w.OwnerId,
                                     ActivityDate = w.CloseDate.addMonths(1));
                
                taskList.add(newT);
                if(String.isBlank(w.AccountId)){
                    w.AccountId.addError('Closed won opportunity should be associated with a specific Account');
                }
            }
        }
        if(taskList.size()>0){
            insert taskList;
        }
    }
}