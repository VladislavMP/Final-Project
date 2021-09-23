import { LightningElement, api, wire, track } from 'lwc';
import getTodoList from '@salesforce/apex/TodoQuery.getTodoList';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { refreshApex } from '@salesforce/apex'
import TODO_OBJECT from '@salesforce/schema/ToDo__c';
import NAME_FIELD from '@salesforce/schema/ToDo__c.Name';

export default class AppTodo extends LightningElement {

    get dateNow() {
        const month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
        let date = new Date();
        let fulDate = date.getDate() + " " + month[date.getMonth()] + " " + date.getFullYear();
        return fulDate
    }

    recordTypeToday = 'today';
    recordTypeTomorrow = 'tomorrow';
    recordTypeLater = 'later';

    @wire(getTodoList)
    listTodo

    @api recordId;
    @api optionVal;
    @track objectInfo;
    @track recordTypeIdVal;

    modalWindow = false;
    formRecType = false;
    form = false;
    objectApiName = TODO_OBJECT;
    fields = [NAME_FIELD];

    @wire(getObjectInfo, { objectApiName: TODO_OBJECT })
    objectInfo;

    get recordTypeId() {
        let recordtypeinfo = this.objectInfo.data.recordTypeInfos;
        let uiCombobox = [];
        for (let item in recordtypeinfo) {
            if (recordtypeinfo.hasOwnProperty(item) && recordtypeinfo[item].name !== "Master") {
                uiCombobox.push({ label: recordtypeinfo[item].name, value: recordtypeinfo[item].recordTypeId })
            }
        }
        return uiCombobox;
    }

    changeHandler(event) {
        this.optionVal = event.target.value;
        this.recordTypeIdVal = this.optionVal
    }

    handleChange(event) {
        const rtis = this.objectInfo.data.recordTypeInfos;
        this.recordTypeIdVal = (Object.keys(rtis).find(rti => rtis[rti].name === this.optionVal));
        this.closeModal();
    }

    openWindow() {
        this.modalWindow = true;
        this.formRecType = true;
    }

    closeWindow() {
        this.modalWindow = false;
    }

    handleSuccess(event) {
        refreshApex(this.listTodo);
        const toastEvent = new ShowToastEvent({
            title: "Todo created",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}