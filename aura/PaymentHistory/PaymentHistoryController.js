({
    doInit: function(cmp, event, helper) {
        cmp.set("v.columns", [
            { label: "Account Number", fieldName: "Account_Number", type: "text" },
            { label: "Payment Date", fieldName: "Payment_Date", type: "date" },
            {
                label: "Amount",
                fieldName: "Amount",
                type: "currency",
                typeAttributes: { currencyCode: "USD", maximumSignificantDigits: 5 }
            }
        ]);
        
        var action = cmp.get("c.getPaymentsData");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server: ", response.getReturnValue());
                cmp.set("v.data", response.getReturnValue());
            } else if (state === "INCOMPLETE") {
                // do something
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    },
    handleSuccess: function(cmp) {
        $A.get('e.force:refreshView').fire();
    },
    handleSubmit: function(cmp, event, helper) {
        event.preventDefault();
        var eventFields = event.getParam("fields");
        eventFields["Payment_history_Synced_On__c"] = new Date();
        console.log(JSON.stringify(eventFields));
        cmp.find("caseForm").submit(eventFields);
    },
    handleError:function(cmp, event, helper) {
        alert();
        console.log(JSON.stringify(event));
    }
});