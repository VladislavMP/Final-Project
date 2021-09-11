public with sharing class ToDoWrapper {
    public ToDo__c toDo { get; set; }
    public String recordTypeName { get; set; }

    public ToDoWrapper(ToDo__c toDo, String recordTypeName) {
		this.toDo = toDo;
        this.recordTypeName = recordTypeName;
    }
}