public class HTTP_bitLy {
    public String doRequest(String body) {


        Http httpObject = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(System.label.bitly_URL);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', '*/*');
        request.setHeader('Authorization', 'Bearer '+System.label.bitly_token);
        // request.setHeader('Authorization', ''+System.label.shortio_Token);
        request.setBody(body);

        HttpResponse response = httpObject.send(request);

        Map<String,Object> DataJSON = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        System.debug(response.getBody());
        return (String)DataJSON.get('link');

    }
}
