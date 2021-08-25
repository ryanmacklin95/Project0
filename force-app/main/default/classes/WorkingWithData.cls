public class WorkingWithData {
	//SOQL
	//-SF Object Query Language
	//-SQL familiar syntax, but it is different
	//- we can use this natively in Apex
	//- Querying for data in our org
	//	-using sObjects that exist in org
	//	-Getting records that exist for our org
		
    public static void SOQL() 
    {
        List<Account> myResults = [SELECT name FROM Account];
        Account my1Account = [SELECT name FROM Account LIMIT 1];
        System.debug(myResults[0].name);
        
        Set<String> namesToFilter = new Set<String>();
        
        //SOQL Clauses
        // - LIMIT : Limit how many records are returned
        // - OFFSET : Changes where the records start from
        // 	-	Used together to perform pagination
        // 	- WHERE : adds on a filter to your query
        // 	 - SELECT name FROM Account WHERE name = 'Edge Communications'
        // 	 - SELECT name FROM Account WHERE name LIKE '%a%a%' % is the wildcard in SOQL
        // 	 - SELECT name FROM Account WHERE name IN : namesToFilter
        // 	 - NOT, OR, AND (SELECT name FROM Account WHERE NOT name = 'Edge Communications')
        // - ORDER BY
        // 	 - Sets teh order of records
        // 	 - ASC or DESC, NULLS FIRST or NULLS LAST
        // 	 
        // - WITH SECURITY ENFORCED
        // 	 - If you don't have access to something in the query, throws an error
        // 	 
        // - FIELDS()
        // 	 - ALL, STANDARD, CUSTOM
        // 	 - this will respect field level security
        // 	 - SELECT FIELDS(ALL) FROM Account
        // 
        // - FORMAT()
        // 	 - Formats number, date, time, currency fields
        // 	 
        // - FOR
        //   - VIEW : updates the last viewed date field on the records
        //   - REFERENCE : updates the last referenced date field on the records
        //   - UPDATE : locks record from being updated by anyone except the locker until the transaction ends
        //   - SELECT name FROM Account FOR VIEW
        
    }
    
    
    public static void AggregateFunctions()
    {	
        AggregateResult myResult = [SELECT COUNT(id) numAccounts FROM Account];
        System.debug(myResult.get('numAccounts'));
                                   
        // when you use an agfuntion, the return type is now an agResult
        // Still use the .get()
        // Can give fields an alias to reference them by, otherwise the name of the fields is expr#, starting with 0
        // Aggregate Functions
        //  - AVG(), COUNT(), MIN(), MAX(), SUM(), COUNT_DISTINCT()
        //  - SELECT FORMAT(AVG(annualRevenue)) FROM Account
        //  - GROUP BY 
        //  -HAVING
        //  	- filters the group by clause
        //  	- SELECT rating, FORMAT(AVG(annualRevenue)) FROM Account GROUP BY rating HAVING NOT rating = null
        
    }
    
    public static void DateFunctions()
    {
        //Date Functions
        // - CALENDAR_YEAR(), CALENDAR_QUARTER(), DAY_IN_MONTH(), DAY_IN_WEEK(), DAY_IN_YEAR(), DAY_ONLY(), FISCAL_MONTH(),
        // - FISCAL_QUARTER(), FISCAL_YEAR(), HOUR_IN_DAY,(), WEEK_IN_MONTH(), WEEK_IN_YEAR()
        // 	- SELECT DAY_IN_WEEK(CloseDate) FROM Opportunity GROUP BY DAY_IN_WEEK(CloseDate)
    }
    
    public static void RelationshipQueries()
    {
        List<Account> myResults = [SELECT name, (SELECT name FROM Contacts) FROM Account];
        for(account currAccount : myResults)
        {
            List<contact> associatedContacts = currAccount.contacts;
        }
        
        // Can query in both child and parent objects in a query
        // - Parent to child
        // 	-Accounts -> Contacts
        // 	- SELECT name, (SELECT name FROM Contacts) FROM Account
        // -Child to Parent
        // 	-Contact -> Accounts
        // 	Select name, Account.name FROM contact
        // 	
        // 	Relationship query and filtering query 
        // 	 - Select name, (SELECT name FROM Contacts) FROM Account WHERE id IN (SELECT accountID FROM Contact WHERE name LIKE 'a%')
    }
    
    public static void DML()
    {
        //Account myNewAccount = new Account(name = 'My Test Account', rating = 'Hot', annualRevenue = 150000000);
        //Insert myNewAccount;
        
        
        //Contact myNewContact = new Contact(lastName = 'New', accountID = myNewAccount.id);
        //Insert myNewContact;
        
        //List<Account> toDelete = [SELECT name FROM Account WHERE name = 'My Test Account'];
        //Delete toDelete;
        
       // Account toUpdate = [SELECT name, rating, active__c FROM Account WHERE name = 'My Test Account' LIMIT 1];
       // toUpdate.Active__c = 'Yes';
       // Update toUpdate;
        
        
        // Data Manipulation Language 
        //	- This allows us to persist changes to the database
        //	- Insert
        //	- Update
        //	- Delete
        //	- Merge
        //	- Upsert
        
        
        List<Contact> myContactList = new List<Contact>();
        myContactList.add(new Contact(lastName = 'Valid Contact'));
        myContactList.add(new Contact(firstName = 'Invalid Contact'));
        
        Database.Insert(myContactList, false);
         
    }
    
    public static void GovernorLimits()
    {
        List<Contact> toInsert = new List<Contact>();
        
        for(integer i = 0; i < 152; i++)
        {
            toInsert.add(new Contact(lastName='This will fail!'));
        }
        Insert toInsert;
        
        // soql queries also have gov limits
        // we should map together records that need to be accessed together
    }
    
    public static void TCL() 
    {
        // Transaction Control Language
        // - Set Savepoints
        // - Rollback to savepoints
        
        Savepoint sp1 = Database.SetSavepoint();
        //perform some dml
        
        Database.Rollback(sp1);
        
        // Does not revert ID's 
        // Discards any DML that occurs after the savepoint
        // If you rollback to a savepoint that occurs before another savepoint, that point is no longer valid
        // Rolling back to a savepoint does not reset your gov limits
        // Setting a savepoint counts as a DML operation
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}