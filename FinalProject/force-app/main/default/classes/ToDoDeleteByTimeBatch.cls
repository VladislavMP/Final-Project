public with sharing class ToDoDeleteByTimeBatch implements Database.Batchable<SObject>, Database.Stateful, Database.AllowsCallouts{

    private Integer days;
    private Integer minutes;

    public Database.QueryLocator start(Database.BatchableContext context){
        List<ToDoTimeToDelete__mdt> ToDoTimeToDeleteList = [
            SELECT DaysPast__c, MinutesPast__c
            FROM ToDoTimeToDelete__mdt 
            WHERE IsActive__c = true
            ORDER BY DaysPast__c, MinutesPast__c
        ];
        If (ToDoTimeToDeleteList.size() > 0){
            Days = (Integer) ToDoTimeToDeleteList[0].DaysPast__c;
            Minutes = (Integer) ToDoTimeToDeleteList[0].DaysPast__c;
        }
        else {
            System.abortJob(context.getJobId());
        }

        return Database.getQueryLocator('SELECT CreatedDate, External_Id__c FROM ToDo__c');
    }

    public void execute(Database.BatchableContext context, List<ToDo__c> toDos){

        List<ToDo__c> toDosForDelete = new List<ToDo__c>();
        Long deleteTimeMinutes = days * 24 * 60 + minutes;
        Long nowTimeMinutes = Datetime.now().getTime() / 60000;
        for (ToDo__c toDo : toDos){
            Long toDoTimeMinutes = toDo.CreatedDate.getTime() / 60000;
            if (nowTimeMinutes - toDoTimeMinutes >= deleteTimeMinutes){
                toDosForDelete.add(toDo);
            }
        }

        List<Id> toDoExtertalIds = ToDoHelper.getExternalIdList(toDosForDelete);

        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(toDoExtertalIds, 'DELETE');
        HttpResponse response = httpConnection.send(request);

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        delete toDosForDelete;

    }

    public void finish(Database.BatchableContext context){}
}