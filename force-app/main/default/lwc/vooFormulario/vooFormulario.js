import { LightningElement} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createVoo from '@salesforce/apex/InsereVoo.createVoo';

export default class vooFormulario extends LightningElement {
    
    partidaValue='';
    chegadaValue='';
    spinner = false;

    handlePartidaChange(event) {
        this.partidaValue = event.detail.recordId;
        console.log(this.partidaValue);
    }

    handleChegadaChange(event) {
        this.chegadaValue = event.detail.recordId;
        console.log(this.chegadaValue);
    }


    matchingInfo = {
        primaryField: {fieldPath: 'Name'},
        additionalFields: [{fieldPath: 'IATA__c'}],
    };

    displayInfo = {
        additionalFields:["IATA__c"]
    }

    handleSubmit(event) {
            this.spinner = true;
            event.preventDefault();

            let vooInsert={
                Partida__c: this.partidaValue,
                Chegada__c: this.chegadaValue,
            };
            vooInsert = JSON.stringify(vooInsert);
            createVoo({vooInsert:vooInsert})
            .then(() => {
                const toastEvent = new ShowToastEvent({
                    title: 'Registro Criado',
                    message: 'Seu registro foi criado com sucesso',
                    variant: 'success',
                });
                this.dispatchEvent(toastEvent);
                this.spinner = false;
            })
            .catch((error) => {
                const toastEvent = new ShowToastEvent({
                    title: 'Erro',
                    message: error.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(toastEvent);
                this.spinner = false;
            });
    }

}