@isTest
public class triggerHandlerTest {

    @isTest
    public static void TP_quickAccount() {
        List<Contact> testList = new List<Contact>();
        Contact testContact = new Contact(FirstName = 'John', LastName = 'Bush', BusinessID__c = 'Test Business', 
                                          recordTypeId = Schema.SObjectType.Contact
            			   				  .getRecordTypeInfosbyName()
                           				  .get('Supplier Contact').getRecordTypeId());
        testList.add(testContact);
        Insert testList;
        triggerHandler.quickAccount(testList);
        Account acc = [SELECT name, Id FROM Account];
        System.Equals(acc.Id, testList[0].accountID);
    }
    @isTest(SeeAllData = True)
    public static void TP_orderEmail() {
        Order testOrder = [SELECT status FROM Order WHERE Order.orderNumber = '00000103'];
        testOrder.status = 'Activated';
        Update testOrder;
    }
}