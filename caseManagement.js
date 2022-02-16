import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateCaseDetails from '@salesforce/apex/CaseDetails_Cntl.updateCaseDetails';
export default class CaseManagement extends LightningElement {
    
    firstName;
    lastName;
    email;
    phone;
    caseDescription;
    // Change Handlers.
    firstNameChangedHandler(event){
        this.firstName = event.target.value;
    }
    lastNameChangedHandler(event){
        this.lastName = event.target.value;
    }
    emailChangedHandler(event){
        this.email = event.target.value;
    }
    phoneChangedHandler(event){
        this.phone = event.target.value;
    }
    descriptionChangedHandler(event){
        this.caseDescription = event.target.value;
    }
    
    // Insert record.
    submitCaseDetails(){  
         
        
        //Calling Server method to check if Case Number is Present, If Yes, Update,else fire toast.
        updateCaseDetails({firstName: this.firstName, lastName: this.lastName, email: this.email, phone: this.phone, caseDesc: this.caseDescription  })
        .then(response => {            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: response,
                    variant: 'success'
                })
            );
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}