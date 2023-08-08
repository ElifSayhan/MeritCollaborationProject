global class LeadBatch implements Database.Batchable<SObject>, Database.Stateful, Schedulable {
    global Integer count = 0;
    //  Database.Stateful anlat önemli konu    
    global Database.QueryLocator start(Database.BatchableContext BC){// Database.Iterable
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead WHERE leadsource = null');
        
    // string içerisinde string kullanımı 'SELECT Id FROM Account WHERE Name = \'Genepoint\'  '
    }   
    global void execute(Database.BatchableContext BC, List<Lead> scope){
        for(Lead leadRecord : scope){
      		leadRecord.LeadSource = 'Manual';
            count++;
        }
        update scope;
        System.debug(count+' record has been updated.');
    }  
    global void finish(Database.BatchableContext BC){
        System.debug('Batch finished: '+count+' record has been updated.');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {'halit.techproed@gmail.com'});
        email.setSubject('Batch Apex');
        email.setPlainTextBody('The batch has completed processing all records : ' + count);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }   
    global void execute(SchedulableContext context){
        LeadBatch myBatch = new LeadBatch();
        Database.executeBatch(myBatch);
    }
}

// String cronExpression = '0 30 23 * * ? ';
// LeaadBatch myBatch = new LeadBatch();
// System.schedule('LeadBatch', cronExpression, schedulable)