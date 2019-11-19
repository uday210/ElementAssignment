({
	getPaymentsFromSoapService : function(cmp,event,helper) {
		   var action = cmp.get("c.getSoapPaymentData");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("From server:SOAP ", response.getReturnValue());
           //     cmp.set("v.data", response.getReturnValue());
             //   cmp.set('v.loadingCompleted',true);
            } else if (state === "INCOMPLETE") {
                // do something
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                     //   console.log("Error message: " + errors[0].message);
                     
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        
        $A.enqueueAction(action);
    
	}
})