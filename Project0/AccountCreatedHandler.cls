public class AccountCreatedHandler {
	
    public static void sendEmail(List<Account> newAccs){
        List<String> emailAddresses = new List<String>();
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage>();
        for (Account a : newAccs){
            if(isCustomerAccount(a)){
                emailAddresses.add(a.email__c);
                message.toaddresses = emailAddresses;
                message.subject = 'Account created successfully!';
                message.plaintextbody = 'Your MaDonal account has been created! Your username is ' + a.name;
                messages.add(message);
            }
        }
        System.debug(messages);
		Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
    
    private static boolean isCustomerAccount(Account toCheck){
        if(toCheck.RecordTypeId == '0125e0000007mwb'){
            return true;
        }
        return false;
    }
}