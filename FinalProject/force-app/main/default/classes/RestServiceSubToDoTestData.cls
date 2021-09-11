public with sharing class RestServiceSubToDoTestData {

    public static Sub_ToDo__c createTestSubToDo(ToDo__c toDo) {
        Sub_ToDo__c subToDo = new Sub_ToDo__c(
            Name='Test subtodo', ToDo__c = toDo.Id
        );
        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert subToDo;
        return subToDo;
    }         

    public static String createJsonBody(Sub_ToDo__c subToDo){
        String jsonBody = JSON.serialize(
            new List<Sub_ToDo__c>{subToDo});

        return jsonBody;
    }

    public static String createJsonBody(Id Id){
        String jsonBody = JSON.serialize(new List<Id>{Id});

        return jsonBody;
    }

    public static RestRequest createTestRequest(String jsonBody, String method, String requestUri){
        RestRequest request = new RestRequest();
        request.requestUri = requestUri;
        request.httpMethod = method;
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(jsonBody);

        return request;
    }
}
