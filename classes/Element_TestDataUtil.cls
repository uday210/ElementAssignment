public class Element_TestDataUtil {
    public static list<Contact> getBulkContacts() {
        // Load the test contacts from the static resource
        List<Contact> ls = (List<Contact>) Test.loadData(Contact.sObjectType, 'Elelement_testContacts');
      
         return ls; 
    }
}