public class bitLy_invoke {

    @InvocableMethod(label='Create Shorten URL' description='this function creates a short link')
    public static void bitly_invokeMethod(List<Id> ids) {
        
        Invoice_DuitKu__c invoice = [SELECT Id, Payment_URL__c FROM Invoice_DuitKu__c WHERE Id=:ids];

        String body = JSON.serialize(new Map<String, Object>{
            'long_url' => String.valueOf(invoice.Payment_URL__c),
            'domain' => 'bit.ly',
            'group_guid' => System.label.bitly_groupID
            
        });

        createShortURL(body);
    }

    @future(callout=true)
    public static void createShortURL(String body) {

        HTTP_bitLy service = New HTTP_bitLy();

        

        System.Debug('ShortURL : '+service.doRequest(body));
    }
    
}
