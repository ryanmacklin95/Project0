public class orderTriggerHandler {
	
    public static void sendOrderEmail(List<Order> orderToUpdate){
       	// This is the logic of the ordertrigger after the order is updated, 
	    // this works, however I want to follow best practices by placing this in a handler
	    // 
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
    	List<String> sendTo = new List<String>(); // made email a list for easy update if I want to add more emails
    	sendTo.add('isaac.lopez@revature.net'); // add my rev email, the email of all my users.
        
    	for(Order orderEmail : orderToUpdate){
            if (orderEmail.Order_Complete__c == true){
        		Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        		mail.setToAddresses(sendTo);
        		mail.setSubject('Order: '+ orderEmail.OrderNumber +' Has been completed');
        		String body = 'Order is complete. Good Job';
        		mail.setHtmlBody(body);
        		mails.add(mail);
			}
    		Messaging.sendEmail(mails);
		}
    }
}