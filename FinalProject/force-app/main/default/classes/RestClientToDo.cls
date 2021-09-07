public with sharing class RestClientToDo {

/*    public static ToDo__c getToDo(String id) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT + id);
        request.setMethod('GET');
        HttpResponse response = httpConnection.send(request);
        ToDo__c toDo = (ToDo__c) JSON.deserialize(response.getBody(), ToDo__c.class);
        return toDo;
    }*/

    @future(callout=true)
    public static void createToDo(List<Id> ids) {
        List<ToDo__c> toDos = [SELECT Id, Project_Name__c, Name, RecordTypeId, External_Id__c
            FROM ToDo__c 
            WHERE Id =: ids];
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(wrappers, 'POST');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
        	toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        update toDos;
    }

    @future(callout=true)
    public static void deleteToDo(List<Id> ids) {
        List<ToDo__c> toDos = [
            SELECT Id, External_Id__c
            FROM ToDo__c 
            WHERE Id =: ids
        ];
        List<String> extertalIds = new List<String>();
        for(ToDo__c todo : toDos){
        	extertalIds.add(toDo.External_Id__c);
        }
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(extertalIds, 'DELETE');
        HttpResponse response = httpConnection.send(request);
    }

    @future(callout=true)
    public static void upsertToDo(List<Id> ids) {
        List<ToDo__c> toDos = [SELECT Id, Project_Name__c, Name, External_Id__c, RecordTypeId
            FROM ToDo__c 
            WHERE Id =: ids];
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
        
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(wrappers, 'PUT');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
        	toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        update toDos;
    }    
    
    @future(callout=true)
    public static void updateToDo(List<Id> ids) {
        List<ToDo__c> toDos = [SELECT Id, Project_Name__c, RecordTypeId, Name, External_Id__c
            FROM ToDo__c 
            WHERE Id =: ids];
        List<ToDoWrapper> wrappers = RestClientToDoHelper.wrapToDos(toDos);
       
        Http httpConnection = new Http();
        HttpRequest request = RestClientToDoHelper.createRequest(wrappers, 'PATCH');
        HttpResponse response = httpConnection.send(request);
        
        Map<String, String> externalIdsMap  = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(ToDo__c todo : toDos){
        	toDo.External_Id__c = externalIdsMap.get(toDo.Id);
        }

        update toDos;
    }  
    
}