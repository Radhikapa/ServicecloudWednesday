//for creating case in LWC we need to brdige LWC with salesforce
public class  CaseDetails_Cntl {
    @AuraEnabled
    public static string updateCaseDetails(string firstName,string lastName,string email,string phone,String caseDesc){
        System.debug('firstName -> '+firstName);
        System.debug('lastName -> '+lastName);
        System.debug('email -> '+email);
        System.debug('phone -> '+phone);
        System.debug('caseDesc -> '+caseDesc);

        try{
            //Based on email create list
            List<Contact> contactList = new List<Contact>([SELECt ID,Email FROM Contact WHERE Email=: email ORDER BY CreatedDate DESC NULLS LAST Limit 1]);
//create case and add Web and installation and insert into salesforce
            Case objCase = new Case();
            objCase.description = caseDesc;
            objCase.Origin = 'Web';
            objCase.Reason = 'Installation';
            if(!contactList.isEmpty()){
                objCase.ContactId = contactList[0].Id;
            }
            insert objCase;

            /*List<Case> caseList;
            if(String.isNotEmpty(caseNumber)){
                caseList = new List<Case>([SELECT ID,Description, CaseNumber, Comments FROM Case WHERE CaseNumber =:caseNumber]);
                if(!caseList.isEmpty()){
                    System.debug('Comments -> '+caseList[0].Comments);
                    caseList[0].Comments = caseComts;
                    caseList[0].Description = caseDesc;
                    update caseList;
                    System.debug('Comments -> '+caseList[0].Comments);

                    return 'Case details submitted successsfully';
                }else{
                    return 'Case details not found';
                }
            }
            return 'Check your Case Number and try again.';   */
            Case newCase = new Case();
            newCase = [SELECT ID,CaseNumber FROM Case WHERE Id=: objCase.Id LIMIT 1];
            return 'Case details submitted successsfully '+newCase.CaseNumber;  
        }catch(exception e){
            return e.getMessage();
        }   
    }
}