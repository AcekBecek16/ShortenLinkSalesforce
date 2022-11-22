public class bitLy_invoke {

    @InvocableMethod(label='Create Shorten URL' description='this function creates a short link')
    public static void bitly_invokeMethod(List<Id> ids) {
        
        SurveyInvitation surveyInv = [SELECT Id, Record_ID__c, Object_API_Name__c, SPK_Project__c, InvitationLink FROM SurveyInvitation WHERE Id=:ids];

        String body = JSON.serialize(new Map<String, Object>{
            // 'long_url' => String.valueOf(surveyInv.InvitationLink),
            // 'domain' => 'bit.ly',
            // 'group_guid' => System.label.bitly_groupID
            'domain' => 'msforce.id',
            'originalURL' => String.valueOf(surveyInv.InvitationLink)
            
        });

        createShortURL(body, String.valueOf(surveyInv.Object_API_Name__c), String.valueOf(surveyInv.Record_ID__c));
    }

    @future(callout=true)
    public static void createShortURL(String body, String ObjectAPIName, String RecordID) {

        HTTP_bitLy service = New HTTP_bitLy();
        String shortURL = service.doRequest(body);

        if (ObjectAPIName=='Project__c') {
            List<Project__c> project = [SELECT Id, Survey_URL__c FROM Project__c WHERE Id=:RecordID];
            for (Project__c ListProject : project) {
                ListProject.Survey_URL__c = (String)shortURL;
            }
            Update project;
        }else {
            List<Case> obj_case = [SELECT Id, Survey_URL__c FROM Case WHERE Id=:RecordID];
            for (Case ListCase : obj_case) {
                ListCase.Survey_URL__c = (String)shortURL;
            }
            Update obj_case;
        }

        System.Debug('ShortURL : '+shortURL);
    }
    
}
