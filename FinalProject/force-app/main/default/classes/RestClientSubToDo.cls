public with sharing class RestClientSubToDo {

    @future(callout=true)
    public static void createSubToDo(List<Id> ids) {
        List<Sub_ToDo__c> subToDos = [
            SELECT Id, Name, External_Id__c, ToDo__c, ToDo__r.External_Id__c, Status__c
            FROM Sub_ToDo__c 
            WHERE Id =: ids
        ];

        List<Sub_ToDo__c> newSubToDos = RestClientSubToDoHelper.createRecordsForRequest(subToDos);

        Http httpConnection = new Http();
        HttpRequest request = RestClientSubToDoHelper.createRequest(newSubToDos, 'POST');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(Sub_ToDo__c subTodo : subToDos){
        	subTodo.External_Id__c = externalIdsMap.get(subTodo.Id);
        }

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update subToDos;
    }

    @future(callout=true)
    public static void deleteSubToDo(List<Id> extertalIds) {
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientSubToDoHelper.createRequest(extertalIds, 'DELETE');
        HttpResponse response = httpConnection.send(request);
    } 
    
    @future(callout=true)
    public static void updateSubToDo(List<Id> ids) {
        List<Sub_ToDo__c> subToDos = [
            SELECT Id, Name, External_Id__c, ToDo__c, ToDo__r.External_Id__c, Status__c
            FROM Sub_ToDo__c 
            WHERE Id =: ids
        ];
       
        List<Sub_ToDo__c> newSubToDos = RestClientSubToDoHelper.createRecordsForRequest(subToDos);

        Http httpConnection = new Http();
        HttpRequest request = RestClientSubToDoHelper.createRequest(newSubToDos, 'PATCH');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(Sub_ToDo__c subTodo : subToDos){
            subTodo.External_Id__c = externalIdsMap.get(subTodo.Id);
        }

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        update subToDos;
    }  
    
}
