import { LightningElement, wire, api } from 'lwc';
import { createRecord, deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { refreshApex } from '@salesforce/apex'
import getTodoList from '@salesforce/apex/TodoQuery.getTodoList';
import SUB_TODO_OBJECT from '@salesforce/schema/Sub_ToDo__c';
import NAME_SUB_FIELD from '@salesforce/schema/Sub_ToDo__c.Name';
import NAME_TODO_FIELD from '@salesforce/schema/Sub_ToDo__c.ToDo__c';
import IS_DONE_SUB_FIELD from '@salesforce/schema/Sub_ToDo__c.Is_done__c'
import TODO_ID_FIELD from '@salesforce/schema/ToDo__c.Id';

export default class ListTodo extends LightningElement {
  strName;
  recordTodoId;
  recordTodoName;
  
  @wire(getTodoList)
  listTodo

  @api
  recordtype;

  @api recordId;
  @api objectApiName = SUB_TODO_OBJECT;

  modalWindowAdd = false
  modalWindowEdit = false;
  fields = [NAME_SUB_FIELD, IS_DONE_SUB_FIELD];

  get devTodos(){
    return this.listTodo.data.filter(todo => todo.RecordType.DeveloperName === this.recordtype);
  }

  openAccordion(event){
    let el = event.target.closest('.slds-accordion__section')
    let elBtn = event.target.closest('.todo-name')
    if(!el.classList.contains('slds-is-open')){
      elBtn.childNodes[1].classList.add('btn-arrow-transform');
      el.classList.add('slds-is-open');
    }else{
      elBtn.childNodes[1].classList.remove('btn-arrow-transform')
      el.classList.remove('slds-is-open');
    }
  }

  closeWindowAdd(){
    this.modalWindowAdd = false;
  }

  closeWindowEdit(){
    this.modalWindowEdit = false;
  }

  nameChangedHandler(event){
    this.strName = event.target.value;
  }

  isDoneChangedHandler(event){
    this.strIsDone = event.target.value;
  }

  createSubTodo(){
    let fields = {};
    fields[NAME_SUB_FIELD.fieldApiName] = this.strName;
    fields['ToDo__c'] = this.recordTodoId;
    let objRecordInput = {apiName : SUB_TODO_OBJECT.objectApiName, fields};

    createRecord(objRecordInput).then(response => {
      console.log("response " + response);
      this.dispatchEvent(
        new ShowToastEvent({
        title: "Sub-Todo created",
        variant: "success"
        })
      )
      refreshApex(this.listTodo);
    }).catch(error => {
        alert('Error: ' +JSON.stringify(error));
    });
  }

  editRecord(event){
    this.recordId = event.target.dataset.recordid;
    this.modalWindowEdit = true;
  }

  deleteRecord(event){
    let recordId = event.target.dataset.recordid;
    deleteRecord(recordId)
      .then(()=>{
        this.dispatchEvent(
          new ShowToastEvent({
          title: "Todo deleted",
          variant: "success"
          })
        )
        refreshApex(this.listTodo); 
      })
      .catch((error)=>{
        this.dispatchEvent(
          new ShowToastEvent({
            title: "ERROR",
            message: "Record not deleted",
            variant: "error"
          })
        )
      })
  }

  addNewSubTodo(event){
    this.modalWindowAdd = true
    this.recordTodoId = event.target.dataset.keyid;
    this.recordTodoName = event.target.dataset.keyname;
  }

  handleSuccessEdit() {
    refreshApex(this.listTodo);
    const toastEvent = new ShowToastEvent({
      title: "Sub-Todo edit",
      variant: "success"
    });
    this.dispatchEvent(toastEvent);
  }
}