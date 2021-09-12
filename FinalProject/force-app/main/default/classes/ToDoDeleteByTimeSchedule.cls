public with sharing class ToDoDeleteByTimeSchedule implements Schedulable{

    public void execute(SchedulableContext context) {
        Database.executeBatch(new ToDoDeleteByTimeBatch());
    }
}