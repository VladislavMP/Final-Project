@isTest
private with sharing class ToDoDeleteByTimeTest {

    @testSetup
    static void setup() {
        List<ToDo__c> toDos = new List<ToDo__c>();
        Datetime testDateToDelete = Datetime.now().addYears(-1); 
        for (Integer i = 0; i < 5; i++) {
            toDos.add(new ToDo__c(Name='Test' + i,
                External_Id__c = '000000000000000AAA'));
        }

        ToDoTriggerHandler.disableIntegrationInTriggerFlag = true;
        insert toDos;

        for (Integer i = 0; i < 2; i++) {
            Test.setCreatedDate(toDos[i].Id, testDateToDelete);
        }

        /*ToDoTimeToDelete__mdt testMetadata = new ToDoTimeToDelete__mdt(
            Label = 'Test',
            DaysPast__c = 10,
            MinutesPast__c = 10,
            IsActive__c = true
        );*/
    }

    @isTest 
    static void ToDoDeleteByTimeBatchTest() {

        String responceBody = JSON.serialize(true);
        Test.setMock(HttpCalloutMock.class, new RestClientToDoMock(responceBody)); 
        Test.startTest();
        ToDoDeleteByTimeBatch batch = new ToDoDeleteByTimeBatch();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();

        System.assertEquals(3, [SELECT count() FROM ToDo__c]);
    }
}
