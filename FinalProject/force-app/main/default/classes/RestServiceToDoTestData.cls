public with sharing class RestServiceToDoTestData {

    public static ToDo__c createTestToDo() {
        ToDo__c toDo = new ToDo__c(
            Name='Test todo'
        );

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert toDo;
        return toDo;
    }         

    public static String createJsonBody(ToDo__c toDo, String RecordTypeName) {
        String jsonBody = JSON.serialize(
            new List<ToDoWrapper>{new ToDoWrapper(toDo, RecordTypeName)});

        return jsonBody;
    }

    public static String createJsonBody(Id Id) {
        String jsonBody = JSON.serialize(new List<Id>{Id});

        return jsonBody;
    }

    public static RestRequest createTestRequest(String jsonBody, String method, String requestUri) {
        RestRequest request = new RestRequest();
        request.requestUri = requestUri;
        request.httpMethod = method;
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(jsonBody);

        return request;
    }
}

