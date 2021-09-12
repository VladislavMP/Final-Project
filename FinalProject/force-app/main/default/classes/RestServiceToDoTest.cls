@isTest
public with sharing class RestServiceToDoTest {

    @isTest 
    public static void createRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        String jsonBody = RestServiceToDoTestData.createJsonBody(toDoTest, 'Admins Todo');
        RestRequest request = RestServiceToDoTestData.createTestRequest(
            jsonBody, 
            'POST', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/ToDo/'
        );

        RestContext.request = request;            
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        Map <String, String> toDosIdsMap = RestServiceToDo.createRecord();

        Id toDoId = toDosIdsMap.get(toDoTest.Id);
        ToDo__c toDo = [SELECT Name, External_Id__c, RecordTypeId
            FROM ToDo__c 
            WHERE Id =: toDoId
            LIMIT 1
        ];

        System.assert(toDo != null);
        System.assertEquals('Test todo', toDo.Name);
        System.assertEquals(toDoTest.Id, toDo.External_Id__c);
    }

    @isTest
    public static void deleteRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        String jsonBody = RestServiceToDoTestData.createJsonBody(toDoTest.Id);
        RestRequest request = RestServiceToDoTestData.createTestRequest(
            jsonBody, 
            'DELETE', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/ToDo/'
        );

        RestContext.request = request;
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        RestServiceToDo.deleteRecord();

        List<ToDo__c> toDos = [SELECT Id FROM ToDo__c WHERE Id =: toDoTest.Id];
        System.assert(toDos.size() == 0);
    }

    @isTest 
    public static void updateRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        toDoTest.External_Id__c = toDoTest.Id;
        toDoTest.Name = 'Test todo 1';
        String jsonBody = RestServiceToDoTestData.createJsonBody(toDoTest, 'Admins Todo');
        RestRequest request = RestServiceToDoTestData.createTestRequest(
            jsonBody, 
            'PATCH', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/ToDo/'
        );

        RestContext.request = request; 
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        Map <String, String> toDosIdsMap = RestServiceToDo.updateRecord();

        Id toDoId = toDosIdsMap.get(toDoTest.Id);
        ToDo__c toDo = [SELECT Name, External_Id__c, RecordTypeId
            FROM ToDo__c 
            WHERE Id =: toDoId
            LIMIT 1
        ];

        System.assert(toDosIdsMap != null);
        System.assert(toDo != null);
        System.assertEquals('Test todo 1', toDo.Name);
        System.assertEquals(toDoTest.Id, toDo.External_Id__c);
    }  

}