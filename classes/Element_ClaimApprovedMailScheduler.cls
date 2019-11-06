/*****************
*Author : Uday
*Date : 06/11/2019
*Description : 
*******************/
global class Element_ClaimApprovedMailScheduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Id JobId = Database.executeBatch(new Element_SendClaimApprovedMailToCustomer());
    }
}