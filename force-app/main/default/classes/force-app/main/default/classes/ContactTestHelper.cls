@isTest
public class ContactTestHelper 
{
	public static List<Contact> CreateContacts(Integer numContacts)
    {
        List<Contact> toReturn = new List<Contact>();
        
        for(Integer i = 0; i < numContacts; i++)
        {
            toReturn.add(new Contact(lastName = 'Test Contact ' + i));
        }
        
        return toReturn;
    }
}