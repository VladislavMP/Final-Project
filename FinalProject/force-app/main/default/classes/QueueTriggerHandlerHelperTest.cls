@isTest
private class QueueTriggerHandlerHelperTest {
    static ToDo__c createRecord(String name, String recId) {
        return new ToDo__c(
        	Name = name,
            RecordTypeId = recId
        );
    }
    @isTest static void testAssignmentQueue() {
        Group queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Today'];
        ToDo__c todo = createRecord('Today', '0125g000000RI59AAG');
        System.debug('todo: ' + todo);
        System.debug('todo.recID: ' + todo.RecordTypeId);
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
        QueueTriggerHandlerHelper.assignmentQueue(todos);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
         
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Tomorrow'];
        todo = createRecord('Tomorrow', '0125g000000RI54AAG');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos2 = new List<ToDo__c>();
        todos2.add(todo);
        System.debug('todos2: ' + todos2);
        QueueTriggerHandlerHelper.assignmentQueue(todos2);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
        queue = [SELECT id, Name FROM Group WHERE Type = 'Queue' AND Name = 'Later'];
        todo = createRecord('Later', '0125g000000RI4pAAG');
        System.debug('todo: ' + todo);
        List<ToDo__c> todos3 = new List<ToDo__c>();
        todos3.add(todo);
        System.debug('todos3: ' + todos3);
        QueueTriggerHandlerHelper.assignmentQueue(todos3);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
    }

}