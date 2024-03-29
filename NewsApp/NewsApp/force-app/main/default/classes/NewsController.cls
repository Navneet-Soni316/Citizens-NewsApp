public with sharing class NewsController {
   @AuraEnabled
    public static Map<String,Object> retrieveNews() {
    HttpRequest httpRequest = new HttpRequest();
    httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ade6ad80a2c343408d8594e22fa8beca');
    httpRequest.setMethod('GET');
    Map<String,Object> newJsonData = new Map<String,Object>();
    String strResponse = null;
    try {
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        if(httpResponse.getStatusCode() == 200) {
            strResponse = httpResponse.getBody();
        }
        else {
            throw new CalloutException(httpResponse.getBody());
        }
    }
    catch (Exception e) {
        throw e;
    }
    if(!String.isBlank(strResponse)) {
        //deserializing
        newJsonData = (Map<String,Object>) JSON.deserializeUntyped(strResponse);
    }
    if(!newJsonData.isEmpty()) {
        return newJsonData;
    }
    else {
        return null;
    }
   }
}