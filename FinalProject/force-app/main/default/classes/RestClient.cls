public with sharing class RestClient {
    
    private static final String ENDPOINT = 'callout:RestApi/services/apexrest/ToDo__c/';
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    private static final String HEADER_JSON_CONTENT_TYPE = 'application/json';

    public static ToDo__c getToDo(String id) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT + id);
        request.setMethod('GET');
        HttpResponse response = httpConnection.send(request);
        System.debug(response);
        System.debug(response.getBody());
        ToDo__c toDo = (ToDo__c) JSON.deserialize(response.getBody(), ToDo__c.class);
        return toDo;
    }

    @future(callout=true)
    public static void createToDo(String id) {
        ToDo__c toDo = [SELECT Id, Project_Name__c, Name, RecordTypeId
            FROM ToDo__c 
            WHERE Id =: id];
        
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod('POST');
        request.setBody(JSON.serialize(toDo));
        HttpResponse response = httpConnection.send(request);
        
        toDo.External_Id__c = (String) JSON.deserialize(response.getBody(), String.class);
        update toDo;
    }

    @future(callout=true)
    public static void deleteToDo(Id id) {
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(ENDPOINT);
        request.setMethod('DELETE');
        request.setBody(JSON.serialize(id));
        HttpResponse response = httpConnection.send(request);
        
        //Boolean result = (Boolean) JSON.deserialize(response.getBody(), Boolean.class);
    }

    @future(callout=true)
    public static void upsertToDo(String id) {
        ToDo__c toDo = [SELECT Id, Project_Name__c, Name, External_Id__c, RecordTypeId
            FROM ToDo__c 
            WHERE Id =: id];
        
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod('PUT');
        request.setBody(JSON.serialize(toDo));
        HttpResponse response = httpConnection.send(request);
        
        toDo.External_Id__c = (String) JSON.deserialize(response.getBody(), String.class);
        update toDo;
    }    
    
    @future(callout=true)
    public static void updateToDo(String id) {
        ToDo__c toDo = [SELECT Id, Project_Name__c, RecordTypeId, Name, External_Id__c
            FROM ToDo__c 
            WHERE Id =: id];
        
        Http httpConnection = new Http();
        HttpRequest request = new HttpRequest();

        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod('PATCH');
        request.setBody(JSON.serialize(toDo));
        HttpResponse response = httpConnection.send(request);
        
        toDo.External_Id__c = (String) JSON.deserialize(response.getBody(), String.class);
        update toDo;
    }  
}