trigger TodosTrigger on ToDo__c ( 
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete) {

    if (Trigger.isBefore && Trigger.isInsert){
        ToDoTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate){
        ToDoTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete){
        ToDoTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    
    if (Trigger.isAfter && Trigger.isInsert){
        ToDoTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate){
        ToDoTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete){
        ToDoTriggerHandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUndelete){
        ToDoTriggerHandler.handleAfterUndelete(Trigger.new, Trigger.newMap);
    }
}