@IsTest
private with sharing class RestClientSubToDoTest {
    
    private static final String EXTERNAL_ID = '0012w00000L74CqAAJ';
    private static final String TEST_TODO_NAME = 'Test ToDo';
    private static final String TEST_SUBTODO_NAME = 'Test SubToDo';

    @testSetup
    static void setup() {
        ToDo__c toDo = new ToDo__c(Name = TEST_TODO_NAME);
        
        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert toDo;

        Sub_ToDo__c subToDo = new Sub_ToDo__c(Name = TEST_SUBTODO_NAME, ToDo__c = toDo.Id);

        SubToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert subToDo;
    }

    @IsTest
    static void sendCreateSubToDoRequestTest() {
        Sub_ToDo__c subToDo = [SELECT Id FROM Sub_ToDo__c LIMIT 1];
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        RestClientSubToDo.sendCreateSubToDoRequest(subToDoIds);
        Test.stopTest();

        subToDo = [SELECT External_Id__c FROM Sub_ToDo__c WHERE Id =: subToDo.Id];
        Id externalId = subToDo.External_Id__c;
        System.assertEquals(EXTERNAL_ID, externalId);
    }
    
    @IsTest
    static void sendDeleteSubToDoRequestTest() {
        Sub_ToDo__c subToDo = [SELECT Id FROM Sub_ToDo__c LIMIT 1];
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        Boolean testTry = true;
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        RestClientSubToDo.sendDeleteSubToDoRequest(subToDoIds);
        Test.stopTest();

    }
    
    @IsTest
    static void sendUpdateSubToDoRequestTest() {
        Sub_ToDo__c subToDo = [SELECT Id FROM Sub_ToDo__c LIMIT 1];
        List<Id> subToDoIds = new List<Id>{subToDo.Id};
        String responceBody = JSON.serialize(new Map<String, String>{subToDo.Id => EXTERNAL_ID});

        Test.setMock(HttpCalloutMock.class, new RestClientSubToDoMock(responceBody));            
		Test.startTest();
        RestClientSubToDo.sendUpdateSubToDoRequest(subToDoIds);
        Test.stopTest();

        subToDo = [SELECT Id, External_Id__c FROM Sub_ToDo__c WHERE Id =: subToDo.Id];
        Id externalId = subToDo.External_Id__c;
        System.assertEquals(EXTERNAL_ID, externalId);
    }

}