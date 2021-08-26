public class triggerHandler {
    
    public static void validateAccounts(List<Contact> Contacts) {
        set<Id> contactIds = new set<Id>();
        for (Contact c : Contacts) {
            contactIds.add(c.Id);
        }
        List<Contact> cons = [SELECT name, recordTypeId, Account.recordTypeId FROM Contact WHERE ID IN : contactIds];
        
        for (Contact con : cons) {
            if (!matchingRecordTypes(con)) {
                contacts[0].addError('Account is not valid: Invalid Record Type');
            }
        }
    }
    
    public static void quickAccount(List<Contact> newContacts) {
        // Quick account class creates a list of accounts associated with
        // inserted contacts and links them together
        List<Account> newAccount = new List<Account>();
        Map<String, Contact> contactsByAccount = new Map<String, Contact>();
        
        for(Contact Con : newContacts) {
            if (String.isBlank(Con.AccountId)) {
                Account createdAccount = createAccount(Con);
                newAccount.add(createdAccount);
                contactsByAccount.put(createdAccount.Name, Con);
            }
        }
        Insert newAccount;
        // This code links the accounts using a map created in the previous block
        for (Account acc : newAccount) {
            contactsByAccount.get(acc.Name).accountId = acc.Id;
        }
    }
    
    public static void orderEmail(List<Order> updatedOrders, Map<ID, Order> oldMapOrders) {
        // Methods first function is to create a seperate list of udpated orders
        // having only the order that have been changed from draft to active
		List<Order> orderEmailList = new List<order>();
        for (Order ord : updatedOrders) {
            Order oldOrder = oldMapOrders.get(ord.ID);
            Boolean oldStatus = oldOrder.Status.equals('Draft');
            Boolean newStatus = ord.Status.equals('Activated');
            if (oldStatus && newStatus) {
                orderEmailList.add(ord);
            }
        }
        // Second function creates list of users who have the Inventory Manager role
        // for the purpose of sending the completed order email to those users, then
        // uses helper class to send order email
        List<User> invManagers = [SELECT FirstName, Email FROM User 
                                  WHERE UserRoleID = '00E5e000000LojYEAS'];
        
        List<String> emailList = new List<String>();
        for (User currUser : invManagers) {
            emailList.add(currUser.Email);
        }
        if (orderEmailList.size() > 0) {
            sendOrderEmail(emailList, orderEmailList);
    	}
        
    }
    public static void sendOrderEmail(List<String> emailList,List<Order> orders) {
        // helper method used to send an order completed email to a list of emails
        string orderNumbers ='Order(s): ';
        for (Order ord : orders) {
            orderNumbers += ord.OrderNumber;
            if (orders.size() > 1) {
                orderNumbers += ', ';
            }else {
                orderNumbers  += ' has been completed.';
            }
        }
        List<Messaging.SingleEmailMessage> updateMail = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailList);
        mail.setSubject('Order(s) Complete.');
        mail.setHtmlBody(orderNumbers);
        updateMail.add(mail);
        Messaging.sendEmail(updateMail);
    }
    @testVisible private static Boolean matchingRecordTypes(Contact currContact) {
        Id supCon = Schema.SObjectType.Contact
            			   .getRecordTypeInfosbyName()
                           .get('Supplier Contact').getRecordTypeId();
        Id cusCon = Schema.SObjectType.Contact
            			   .getRecordTypeInfosbyName()
                           .get('Customer Contact').getRecordTypeId();  
        Id supAcc = Schema.SObjectType.Account
                    	   .getRecordTypeInfosbyName()
                           .get('Supplier Account').getRecordTypeId();
        Id cusAcc = Schema.SObjectType.Account
                    	   .getRecordTypeInfosbyName()
                           .get('Customer Account').getRecordTypeId();
        Boolean cusRecordType = (currContact.RecordTypeId == cusCon 
                                 && currContact.Account.recordTypeId == cusAcc);
        Boolean supRecordType = (currContact.RecordTypeId == supCon 
                                 && currContact.Account.recordTypeId == supAcc);
        return(cusRecordType || supRecordType);
        
    }
    
    @testVisible private static Account createAccount(Contact con) {
        // private variable used to create an account associated with a given contact
        // with correct record time and name
        Id supplyContact = Schema.SObjectType.Contact
            			   .getRecordTypeInfosbyName()
                           .get('Supplier Contact').getRecordTypeId();
        Id customerContact = Schema.SObjectType.Contact
            			   .getRecordTypeInfosbyName()
                           .get('Customer Contact').getRecordTypeId();  
        
        Account newAcc = new Account();
        
        if (con.recordtypeID == supplyContact) {
            newAcc.name = con.BusinessID__c;
        	newAcc.RecordTypeId = Schema.SObjectType.Account
                    			.getRecordTypeInfosbyName()
                           		.get('Supplier Account').getRecordTypeId();
        }else if (con.RecordTypeId == customerContact) {
            newAcc.name = con.firstname + ' ' + con.LastName;
        	newAcc.recordTypeId = Schema.SObjectType.Account
                    			.getRecordTypeInfosbyName()
                           		.get('Customer Account').getRecordTypeId();
        } 
        return newAcc;
    }
}