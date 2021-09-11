@isTest 
public with sharing class RestServiceSubToDoTest {
    @isTest 
    public static void createRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        Sub_ToDo__c subToDoTest = RestServiceSubToDoTestData.createTestSubToDo(toDoTest);
        String jsonBody = RestServiceSubToDoTestData.createJsonBody(subToDoTest);
        RestRequest request = RestServiceSubToDoTestData.createTestRequest(
            jsonBody, 
            'POST', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/Sub_ToDo/'
        );

        RestContext.request = request;            
        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        Map <String, String> subToDosIdsMap = RestServiceSubToDo.createRecord();

        Id subToDoId = subToDosIdsMap.get(subToDoTest.Id);
        Sub_ToDo__c subToDo = [SELECT Name, External_Id__c
            FROM Sub_ToDo__c
            WHERE Id =: subToDoId
            LIMIT 1
        ];

        System.assert(subToDo != null);
        System.assertEquals('Test subtodo', subToDo.Name);
        System.assertEquals(subToDoTest.Id, subToDo.External_Id__c);
    }

    @isTest
    public static void deleteRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        Sub_ToDo__c subToDoTest = RestServiceSubToDoTestData.createTestSubToDo(toDoTest);
        String jsonBody = RestServiceSubToDoTestData.createJsonBody(subToDoTest.Id);
        RestRequest request = RestServiceSubToDoTestData.createTestRequest(
            jsonBody, 
            'DELETE', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/Sub_ToDo/'
        );

        RestContext.request = request;
        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        RestServiceSubToDo.deleteRecord();

        List<Sub_ToDo__c> subToDos = [SELECT Id FROM Sub_ToDo__c WHERE Id =: subToDoTest.Id];
        System.assert(subToDos.size() == 0);
    }

    @isTest 
    public static void updateRecordTest() {

        ToDo__c toDoTest = RestServiceToDoTestData.createTestToDo();
        Sub_ToDo__c subToDoTest = RestServiceSubToDoTestData.createTestSubToDo(toDoTest);
        subToDoTest.External_Id__c = subToDoTest.Id;
        subToDoTest.Name = 'Test subtodo 1';
        String jsonBody = RestServiceSubToDoTestData.createJsonBody(subToDoTest);
        RestRequest request = RestServiceSubToDoTestData.createTestRequest(
            jsonBody, 
            'PATCH', 
            'https://firstorg2-dev-ed.lightning.force.com/services/apexrest/Sub_ToDo/'
        );

        RestContext.request = request; 
        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        Map <String, String> subToDosIdsMap = RestServiceSubToDo.updateRecord();

        Id subToDoId = subToDosIdsMap.get(subToDoTest.Id);
        Sub_ToDo__c subToDo = [SELECT Name, External_Id__c
            FROM Sub_ToDo__c 
            WHERE Id =: subToDoId
            LIMIT 1
        ];

        System.assert(subToDosIdsMap != null);
        System.assert(subToDo != null);
        System.assertEquals('Test subtodo 1', subToDo.Name);
        System.assertEquals(subToDoTest.Id, subToDo.External_Id__c);
    }  
}
