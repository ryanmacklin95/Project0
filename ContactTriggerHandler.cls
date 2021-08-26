public class ContactTriggerHandler {

    public static void emailCheck(List<Contact> contactList) {
        
    	Set<String> newEmailSet = new Set<String>();
    	Set<String> currentEmailSet = new Set<String>();
    
    	for (Contact con : contactList) {
        	if ( con.Email != null ) {
            	newEmailSet.add(con.Email);
        	}
    	}
   
    	List<Contact> currentContactList = [Select Id, Email From Contact Where Email IN: newEmailSet AND Email != null];
    	for (Contact con : currentContactList ) {
        	currentEmailSet.add(con.Email);
    	}
    
    	for ( Contact con : contactList ) { // the list we are inserting or updating
        	if ( currentEmailSet.contains( con.Email ) ) {
            	con.Email.AddError(' Duplicate Email is not Allowed ');
                System.debug ('Error, '+con.Email+' is not a unique email');
        	} 
            else {
            	currentEmailSet.add(con.Email);
                System.debug ('No error, '+con.Email+' is a unique email');
        	}
    	}
    }
}