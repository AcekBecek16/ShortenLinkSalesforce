@isTest
private class Test_bitLy {

   @IsTest
   static void test_Project(){
    
    Profile p = [select id from profile where name ='System Administrator'];

    User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');

    Account account = new Account(
        Name = 'Test Account'
    );
    Insert account;

    Employee__c employee = new Employee__c(
        Employee_ID__c = '12345',
        Name = 'Test Employee',
        Active__c = true,
        Role__c = 'Engineer',
        Email__c = 'example@testorg.com'
    );
    Insert employee;

    Project__c project = new Project__c(
        Name = 'Project Test',
        SPK__c = '1234'
    );
    Insert project;

    Survey getSurvey = [SELECT Id, Name FROM Survey WHERE Name = 'Customer Feedback (Solution)'];

    SurveyInvitation surveyInv = new SurveyInvitation(
        Name = 'Survey Invitation',
        SurveyId = getSurvey.Id,
        Object_API_Name__c = 'Project__c',
        Record_ID__c = project.Id,
        SPK_Project__c = project.SPK__c
    );

    Insert surveyInv;

    Test.startTest();
    System.runAs(user){

        Test.setMock(HttpCalloutMock.class, new BitlyHttpCalloutMock());

        List<Id> ids = new List<Id>();
        ids.add(surveyInv.Id);
        bitLy_invoke.bitly_invokeMethod(ids);
        
    }
    Test.stopTest();

    
   }

   @IsTest
   static void testCase(){
    
    Profile p = [select id from profile where name ='System Administrator'];

    User user = new User(Alias = 'newUser', Email='newuser@testorg.com',
         EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
         LocaleSidKey='en_US', ProfileId = p.Id,
         TimeZoneSidKey='America/Los_Angeles', UserName='new-acek@testorg.com');

    Account account = new Account(
        Name = 'Test Account'
    );
    Insert account;

    Employee__c employee = new Employee__c(
        Employee_ID__c = '12345',
        Name = 'Test Employee',
        Active__c = true,
        Role__c = 'Engineer',
        Email__c = 'example@testorg.com'
    );
    Insert employee;

    Case obj_case = new Case(
        Assigned_To__c = employee.Id,
        Type = 'Problems',
        AccountId = account.Id,
        Priority = 'Medium',
        Origin = 'Email'
    );

    Insert obj_case;

    SurveyInvitation surveyInv = new SurveyInvitation(
        Name = 'Survey Invitation',
        SurveyId = '0KdBB00000000AL0AY',
        // InvitationLink = 'https://mmcconsulting--survey.sandbox.my.salesforce.com/survey/runtimeApp.app?invitationId=0KiBA00000006gX&surveyName=customer_feedback_solution&UUID=465fac4b-9114-42da-8885-ebf981278c63',
        Object_API_Name__c = 'Case',
        Record_ID__c = obj_case.Id,
        SPK_Project__c = obj_case.CaseNumber
    );

    Insert surveyInv;

    Test.startTest();
    System.runAs(user){

        Test.setMock(HttpCalloutMock.class, new BitlyHttpCalloutMock());

        List<Id> ids = new List<Id>();
        ids.add(surveyInv.Id);
        bitLy_invoke.bitly_invokeMethod(ids);
        
    }
    Test.stopTest();

   }

}