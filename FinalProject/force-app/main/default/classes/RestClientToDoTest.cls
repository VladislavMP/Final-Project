@IsTest
private with sharing class RestClientToDoTest {
    
    private static final String EXTERNAL_ID = '0012w00000L74CqAAJ';
    private static final String TEST_TODO_NAME = 'Test ToDo';

    @testSetup
    static void setup() {
        ToDo__c toDo = new ToDo__c(Name = TEST_TODO_NAME);
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;

        insert toDo;
    }

    @IsTest
    static void sendCreateToDoRequestTest() {
        ToDo__c toDo = [SELECT Id FROM ToDo__c LIMIT 1];
        List<Id> toDoIds = new List<Id>{toDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody));            
		Test.startTest();
        RestClientToDo.sendCreateToDoRequest(toDoIds);
        Test.stopTest();

        toDo = [SELECT External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals(EXTERNAL_ID, externalId);
    }
    
    @IsTest
    static void sendDeleteToDoRequestTest() {
        ToDo__c toDo = [SELECT Id FROM ToDo__c LIMIT 1];
        List<Id> toDoIds = new List<Id>{toDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody)); 
        Test.startTest();
        RestClientToDo.sendDeleteToDoRequest(toDoIds);
        Test.stopTest();
    }
    
    @IsTest
    static void sendUpdateToDoRequestTest() {
        ToDo__c toDo = [SELECT Id FROM ToDo__c LIMIT 1];
        List<Id> toDoIds = new List<Id>{toDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{toDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody)); 
		Test.startTest();
        RestClientToDo.sendUpdateToDoRequest(toDoIds);
        Test.stopTest();

        toDo = [SELECT Id, External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals(EXTERNAL_ID, externalId);
    }

}