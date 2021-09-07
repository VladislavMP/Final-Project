public with sharing class RestClientToDoHelper {
    
    private static final String ENDPOINT = 'callout:RestApi/services/apexrest/ToDo__c/';
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    private static final String HEADER_JSON_CONTENT_TYPE = 'application/json';
    
    public static HttpRequest createRequest(List<ToDoWrapper> wrappers, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod(method);
        request.setBody(JSON.serialize(wrappers));
        return request;
    }
    
    public static HttpRequest createRequest(List<String> ids, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader(HEADER_CONTENT_TYPE, HEADER_JSON_CONTENT_TYPE);
        request.setEndpoint(ENDPOINT);
        request.setMethod(method);
        request.setBody(JSON.serialize(ids));
        return request;
    }
    
    public static List<ToDoWrapper> wrapToDos(List<ToDo__c> toDos){
        List<ToDoWrapper> wrappers = new List<ToDoWrapper>();
        for(ToDo__c todo : toDos){
        	String recordTypeName = Schema.SObjectType.ToDo__c.
                getRecordTypeInfosById().get(toDo.RecordTypeId).getName();
        	wrappers.add(new ToDoWrapper(toDo, recordTypeName));
        }
        return wrappers;
    }
}
