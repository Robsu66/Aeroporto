import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AeroportoFormulario extends LightningElement {
    spinner = false;

    handleSubmit(){
        this.spinner = true;
    }

    handleSuccess(){
        const toastEvent = new ShowToastEvent({
            title: 'Voo Criado',
            message:
                'Seu voo foi criado com sucesso',
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
        this.spinner = false;
    }
}