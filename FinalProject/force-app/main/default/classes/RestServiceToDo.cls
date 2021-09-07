@RestResource(urlMapping='/ToDo__c/*')
global with sharing class RestServiceToDo {

/*    @HttpGet
    global static ToDo__c getRecord(){
        RestRequest request = RestContext.request;
        String toDoId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        ToDo__c result = [
            SELECT Id, Project_Name__c, RecordTypeId, Name
            FROM Todo__c
            WHERE Id = :toDoId
        ];
        return result;
    }*/

    @HttpPost
    global static Map<String, String> createRecord(){
        RestRequest request = RestContext.request;
		List<ToDoWrapper> wrappers = (List<ToDoWrapper>) 
            JSON.deserialize(request.requestBody.toString(), List<ToDoWrapper>.class);
        List<ToDo__c> toDos = RestServiceToDoHelper.unwrapToDos(wrappers, true);

        insert toDos;
        
        Map<String, String> toDosIdsMap = RestServiceToDoHelper.getToDosIdsMap(toDos);
        return toDosIdsMap;
    }

    @HttpDelete
    global static void deleteRecord(){
        RestRequest request = RestContext.request;
        List<String> toDosIds = (List<String>) 
            JSON.deserialize(request.requestBody.toString(), List<String>.class);
        
        List<ToDo__c> toDos = [SELECT Id 
            FROM ToDo__c 
            WHERE Id = :toDosIds
        ];
        
        delete toDos;
    }

    @HttpPut
    global static Map<String, String> upsertRecord(){
        RestRequest request = RestContext.request;
		List<ToDoWrapper> wrappers = (List<ToDoWrapper>) 
            JSON.deserialize(request.requestBody.toString(), List<ToDoWrapper>.class);
        List<ToDo__c> toDos = RestServiceToDoHelper.unwrapToDos(wrappers, false);
        
        upsert toDos;
        
        Map<String, String> toDosIdsMap = RestServiceToDoHelper.getToDosIdsMap(toDos);
        return toDosIdsMap;
    }

    @HttpPatch
    global static Map<String, String> updateRecord(){
        RestRequest request = RestContext.request;
		List<ToDoWrapper> wrappers = (List<ToDoWrapper>) 
            JSON.deserialize(request.requestBody.toString(), List<ToDoWrapper>.class);
        List<ToDo__c> toDos = RestServiceToDoHelper.unwrapToDos(wrappers, false);

        update toDos;
        
        Map<String, String> toDosIdsMap = RestServiceToDoHelper.getToDosIdsMap(toDos);
        return toDosIdsMap;
    }
}