public with sharing class RestClientToDo {

    @future(callout=true)
    public static void sendCreateToDoRequest(List<Id> ids) {
        List<ToDo__c> toDos = [
            SELECT Id, Project_Name__c, Name, RecordTypeId, External_Id__c, Status__c
            FROM ToDo__c 
            WHERE Id =: ids
        ];
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(wrappers, 'POST');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
        	toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update toDos;
    }

    @future(callout=true)
    public static void sendDeleteToDoRequest(List<Id> extertalIds) {
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(extertalIds, 'DELETE');
        HttpResponse response = httpConnection.send(request);
    } 
    
    @future(callout=true)
    public static void sendUpdateToDoRequest(List<Id> ids) {
        List<ToDo__c> toDos = [
            SELECT Id, Project_Name__c, RecordTypeId, Name, External_Id__c, Status__c
            FROM ToDo__c 
            WHERE Id =: ids
        ];
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
       
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(wrappers, 'PATCH');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
        	toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update toDos;
    }  
    
}