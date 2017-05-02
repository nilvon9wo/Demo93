public class DINJ_PaymentServiceFactory 
{
	public static DINJ_PaymentInterface getPaymentInterface() 
    {
        return (DINJ_PaymentInterface) Type.forName(InheritenceSettings__c.getInstance().PaymentService__c).newInstance();
    }
	
}