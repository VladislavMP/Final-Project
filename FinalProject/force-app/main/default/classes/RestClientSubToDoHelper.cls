public with sharing class RestClientSubToDoHelper {
    

    public static List<Sub_ToDo__c> createRecordsForRequest(List<Sub_ToDo__c> subToDos){
        List<Sub_ToDo__c> newSubToDos = new List<Sub_ToDo__c>();
        for (Sub_ToDo__c subToDo : subToDos) {
            newSubToDos.add(new Sub_ToDo__c(
                Id = subToDo.Id,
                ToDo__c = subToDo.ToDo__r.External_Id__c,
                Name = subToDo.Name,
                External_Id__c = subToDo.External_Id__c,
                Status__c = subToDo.Status__c
            ));
        }

        return newSubToDos;
    }

    public static List<Sub_ToDo__c> parcingResponce(List<Sub_ToDo__c> subToDos, HttpResponse response){
        Map<String, String> externalIdsMap = (Map<String, String>) 
            JSON.deserialize(response.getBody(), Map<String, String>.class);
        for(Sub_ToDo__c subTodo : subToDos) {
        	subTodo.External_Id__c = externalIdsMap.get(subTodo.Id);
        }

        return subToDos;
    }
}