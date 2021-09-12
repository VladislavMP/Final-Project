public class CaseTriggerhandler {
 public static void handleBeforeInsert(List<Case> cases){
        CreateToDoEmail.TodoInsert(cases);
    } 
     public static void handleBeforeUpdate(List<Case> oldList, List<Case> newList, Map<Id, Case> newMap, Map<Id, Case> oldMap) {
        // BEFORE UPDATE LOGIC
    }


    public static void handleBeforeDelete(List<Case> oldList, Map<Id, Case> oldMap) {
        // BEFORE DELETE LOGIC
    }

    public static void handleAfterInsert(List<Case> newList, Map<Id, Case> newMap) {
        
        // EXECUTE AFTER INSERT LOGIC
    }

    public static void handleAfterUpdate(List<Case> oldList, List<Case> newList, Map<Id, Case> newMap, Map<Id, Case> oldMap) {
   
        // AFTER UPDATE LOGIC
    }

    public static void handleAfterDelete(List<Case> oldList, Map<Id, Case> oldMap) {
        
        // AFTER DELETE LOGIC
    }

    public static void handleAfterUndelete(List<Case> newList, Map<Id, Case> newMap) {
        // AFTER UNDELETE LOGIC
    }

}