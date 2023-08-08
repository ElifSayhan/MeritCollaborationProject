Trigger AccountTrigger on Account (after insert,after update) {
    if(Trigger.isAfter && Trigger.isInsert){
       AccountTriggerHandler.handleOpportunityCreation(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
       AccountTriggerHandler.handleOpportunityCreation(Trigger.new);
    }
}