public with sharing class ToDoDeleteByTimeSchedule implements Schedulable{

    public void execute(SchedulableContext context) {
        List<ToDoTimeToDelete__mdt> ToDoTimeToDeleteList = [
            SELECT DaysPast__c, MinutesPast__c
            FROM ToDoTimeToDelete__mdt 
            WHERE IsActive__c = true
        ];

        If(ToDoTimeToDeleteList.size() > 0) {
            Database.executeBatch(new ToDoDeleteByTimeBatch());
        }
    }
}
