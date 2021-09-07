@IsTest
private with sharing class RestClientToDoTest {

    /*@IsTest
    static void getToDoTest() {
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock());
        ToDo__c toDo = RestClientToDo.getToDo('0012w00000L74Cq');
        System.assertEquals(new ToDo__c(Id = '0012w00000L74Cq', Name = 'Test ToDo__c'), toDo);
    }*/
    
    @IsTest
    static void createToDoTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
            
        RestClientToDoMock.id = toDo.Id;    
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock());            
		Test.startTest();
        RestClientToDo.createToDo(toDoIds);
        Test.stopTest();

        toDo = [SELECT External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }
    
   /* @IsTest
    static void deleteToDoTest() {
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock());
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        RestClientToDo.deleteAccount(toDo.Id);

        System.assertEquals(true, result);
    }*/
    
    @IsTest
    static void upsertToDoTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
            
        RestClientToDoMock.id = toDo.Id;    
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock());            
		Test.startTest();
        RestClientToDo.upsertToDo(toDoIds);
        Test.stopTest();
        

        toDo = [SELECT External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }
    
    @IsTest
    static void updateToDoTest() {
        ToDo__c toDo = RestClientToDoTest.createTestToDo('TestName', true);
        List<Id> toDoIds = new List<Id>{toDo.Id};
            
        RestClientToDoMock.id = toDo.Id;
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock());
		Test.startTest();
        RestClientToDo.updateToDo(toDoIds);
        Test.stopTest();

        toDo = [SELECT Id, External_Id__c FROM ToDo__c WHERE Id =: toDo.Id];
        Id externalId = toDo.External_Id__c;
        System.assertEquals('0012w00000L74CqAAJ', externalId);
    }

    static ToDo__c createTestToDo(String name, Boolean needInsert){
        ToDo__c toDo = new ToDo__c(Name = name);
        If (needInsert) insert toDo;
        return toDo;
    }
}