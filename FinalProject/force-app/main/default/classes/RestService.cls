@RestResource(urlMapping='/ToDo__c/*')
global with sharing class RestService {

    private static String assignmentForRecordTypeId(String recordTypeId){
    	if ( recordTypeId == '0125g000000RIKGAA4') recordTypeId = '0125g000000RI59AAG';
    	else if ( recordTypeId == '0125g000000RIKLAA4') recordTypeId = '0125g000000RI4pAAG';
    	else if ( recordTypeId == '0125g000000RIKQAA4') recordTypeId = '0125g000000RI54AAG';
    	return recordTypeId;
    }
    
    @HttpGet
    global static ToDo__c getRecord(){
        RestRequest request = RestContext.request;
        System.debug(request);
        String toDoId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        ToDo__c result = [
            SELECT Id, Project_Name__c, RecordTypeId, Name
            FROM Todo__c
            WHERE Id = :toDoId
        ];
        return result;
    }

    @HttpPost
    global static Id createRecord(){
        RestRequest request = RestContext.request;
        ToDo__c toDo = (ToDo__c) JSON.deserialize(request.requestBody.toString(), ToDo__c.class);

        toDo.External_Id__c = toDo.Id;
        toDo.Id = null;
		toDo.RecordTypeId = RestService.assignmentForRecordTypeId(toDo.RecordTypeId);
        
        insert toDo;
        return toDo.Id;
    }

    @HttpDelete
    global static Boolean deleteRecord(){
        RestRequest request = RestContext.request;
        String toDoId = (Id) JSON.deserialize(request.requestBody.toString(), Id.class);
        
        ToDo__c toDo = [SELECT Id 
            FROM ToDo__c 
            WHERE Id = :toDoId
        ];
        Database.DeleteResult deleteResult = Database.delete(toDo, false);
        return deleteResult.isSuccess();
    }

    @HttpPut
    global static Id upsertRecord(){
        RestRequest request = RestContext.request;
        ToDo__c toDo = (ToDo__c) JSON.deserialize(request.requestBody.toString(), ToDo__c.class);
        
        toDo.RecordTypeId = RestService.assignmentForRecordTypeId(toDo.RecordTypeId);
        String id = toDo.External_Id__c;
        toDo.External_Id__c = toDo.Id;
        toDo.Id = id;
        
        upsert toDo;
        return toDo.Id;
    }

    @HttpPatch
    global static Id updateRecord(){
        RestRequest request = RestContext.request;
        ToDo__c toDo = (ToDo__c) JSON.deserialize(request.requestBody.toString(), ToDo__c.class);
        
        toDo.RecordTypeId = RestService.assignmentForRecordTypeId(toDo.RecordTypeId);
        String id = toDo.External_Id__c;
        toDo.External_Id__c = toDo.Id;
        toDo.Id = id;

        update toDo;
        return toDo.Id;
    }
}
