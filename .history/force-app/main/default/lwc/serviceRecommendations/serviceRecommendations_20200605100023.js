/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';

export default class ServiceRecommendations extends LightningElement {
    @track returnRecommendations;
    @track contactId;
    @track serviceId;

    handleRequestRecommendations(){
        console.log('getting recommendations');
        // fetch('https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=' 
        //             + this.fromCurrencyValue + '&to_currency=' + this.toCurrencyValue + '&apikey=4W7NZUQNJ061YHHF', // End point URL
        // {
        //     // Request type
        //     method:"GET",
            
        //     headers:{
        //         // content type
        //         "Content-Type": "application/json",
        //         // adding your access token 
        //         "Authorization": "OAuth ",
        //     }
        // })
        // .then((response) => {
        //     return response.json(); // returning the response in the form of JSON
        // })

        // .then((jsonResponse) => {
        //     // what does response object look like? convert this to what is in the platform?
        //     let objData = {
        //         From_Currency_Name : '',
        //         From_Currency_Code : '',
        //         To_Currency_Name : '',
        //         To_Currency_Code : '',
        //         Exchange_Rate : '',
        //         Last_Refersed : '',
        //     };

        //     window.console.log('jsonResponse ===> '+JSON.stringify(jsonResponse));
        //     // retriving the response data
        //     //let exchangeData = jsonResponse['Realtime Currency Exchange Rate'];

        //     // adding data object
        //     // objData.From_Currency_Code = exchangeData['1. From_Currency Code'];
        //     // objData.From_Currency_Name = exchangeData['2. From_Currency Name'];
        //     // objData.To_Currency_Code = exchangeData['3. To_Currency Code'];
        //     // objData.To_Currency_Name = exchangeData['4. To_Currency Name'];
        //     // objData.Exchange_Rate = exchangeData['5. Exchange Rate'];
        //     // objData.Last_Refershed = exchangeData['6. Last Refreshed'];

        // fields to include:
        // name
        // recommendation %
        // service type
        //


        //     // adding data object to show in UI
        //     this.returnRecommendations = objData;
        // })
        // .catch(error => {
        //     window.console.log('callout error ===> '+JSON.stringify(error));
        // })
    }

    handleSendReferral(){
        let eventParams = {
            showFlow: true,
            contactId: '0036300000ZmhqmAAB',  
            serviceId: 'a0263000003x85qAAA'
        };
        
        const flowLaunchEvent = new CustomEvent('flowLaunch', {
            detail: {
                eventParams
            },
        });
        // Fire the custom event
        
        this.dispatchEvent(flowLaunchEvent);
        
    }

    handleRelevancePopover(){
        window.console.log('handle popover');
    }

    handleShowMoreDropdown(){
        window.console.log('toggle drop down');
    }

    handleHideForThisContact(){
        window.console.log('toggle hide for contact');
    }

    handleHideForAllContacts(){
        window.console.log('toggle hide for all contacts');
    }
}