trigger CaseTrigger on Case (before insert) {

    if (Trigger.isBefore && Trigger.isInsert){
        CaseTriggerhandler.handleBeforeInsert(Trigger.new);
    }
 	 if (Trigger.isBefore && Trigger.isUpdate) {
        CaseTriggerhandler.handleBeforeUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        CaseTriggerhandler.handleBeforeDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isInsert) {
        CaseTriggerhandler.handleAfterInsert(Trigger.new, Trigger.newMap);
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        CaseTriggerhandler.handleAfterUpdate(Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete) {
        CaseTriggerhandler.handleAfterDelete(Trigger.old, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isUndelete) {
        CaseTriggerhandler.handleAfterUndelete(Trigger.new, Trigger.newMap);
    }

}