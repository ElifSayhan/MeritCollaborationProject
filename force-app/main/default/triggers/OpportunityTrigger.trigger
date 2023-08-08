trigger OpportunityTrigger on Opportunity (after update) {
    
        if(Trigger.isAfter || Trigger.isUpdate){
            OpportunityTriggerHandler.updateNewTaskForCWonOpp(Trigger.new, Trigger.oldMap);
      }
}