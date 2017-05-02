public class DINJ_PaymentRunner 
{
	public static void pay() 
    {
        DINJ_PaymentInterface payment = DINJ_PaymentServiceFactory.getPaymentInterface();
        System.debug(payment.processPayment());
    }

}