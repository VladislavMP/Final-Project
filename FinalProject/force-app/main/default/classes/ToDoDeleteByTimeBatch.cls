public with sharing class ToDoDeleteByTimeBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts{

    private static final String SOBJECTURL = 'ToDo__c/';

    public Database.QueryLocator start(Database.BatchableContext context){
        List<ToDoTimeToDelete__mdt> ToDoTimeToDeleteList = [
            SELECT DaysPast__c, MinutesPast__c
            FROM ToDoTimeToDelete__mdt 
            WHERE IsActive__c = true
            ORDER BY DaysPast__c, MinutesPast__c
        ];

        Integer days;
        Integer minutes;
        If (ToDoTimeToDeleteList.size() > 0){
            days = (Integer) ToDoTimeToDeleteList[0].DaysPast__c;
            minutes = (Integer) ToDoTimeToDeleteList[0].DaysPast__c;
        }
        else {
            System.abortJob(context.getJobId());
        } 

        Integer deleteTimeMinutes = days * 24 * 60 + minutes;
        Datetime deleteDatetime = Datetime.now().addMinutes(-deleteTimeMinutes);

        return Database.getQueryLocator('SELECT External_Id__c FROM ToDo__c WHERE CreatedDate <: deleteDatetime');
    }

    public void execute(Database.BatchableContext context, List<ToDo__c> toDosForDelete){

        List<Id> toDoExtertalIds = ToDoHelper.getExternalIdList(toDosForDelete);

        String jsonBody = JSON.serialize(toDoExtertalIds);
        HttpResponse response = RestClient.sendRequest(jsonBody, 'DELETE', SOBJECTURL);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        delete toDosForDelete;

    }

    public void finish(Database.BatchableContext context){}
}