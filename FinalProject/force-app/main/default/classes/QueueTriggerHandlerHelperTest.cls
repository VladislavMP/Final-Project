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
        ToDo__c todo = createRecord('Today', '012090000006M9QAAU');
        System.debug('todo: ' + todo);
        System.debug('todo.recID: ' + todo.RecordTypeId);
        List<ToDo__c> todos = new List<ToDo__c>();
        todos.add(todo);
       // System.debug('todos1: ' + todos1);
        QueueTriggerHandlerHelper.assignmentQueue(todos);
        System.debug(todo.OwnerId);
        System.assertEquals(todo.OwnerId, queue.Id);
        
  
    }
}