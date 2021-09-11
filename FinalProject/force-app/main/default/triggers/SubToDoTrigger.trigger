trigger SubToDoTrigger on Sub_ToDo__c ( 
    before insert,
    before update,
    before delete,
    after insert,
    after update,
    after delete,
    after undelete) {

    if (Trigger.isBefore && Trigger.isInsert){
        SubToDoTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate){
        SubToDoTriggerHandler.handleBeforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete){
        SubToDoTriggerHandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }
    
    if (Trigger.isAfter && Trigger.isInsert){
        SubToDoTriggerHandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate){
        SubToDoTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete){
        SubToDoTriggerHandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUndelete){
        SubToDoTriggerHandler.handleAfterUndelete(Trigger.new, Trigger.newMap);
    }
}