/**
 * Executing Data Operations as Single Transactions
 * @see Apex Workbook, page 49
 **/
public class WARE_MerchandiseOperations 
{
	private static void addLineItem(Id invoiceId, Id merchandiseId, Decimal price, Integer quantitySold)
	{
		Line_Item__c lineItem = new Line_Item__c (								// Add a new line item to the invoice 
				name 			= '1',
				invoice__c 		= invoiceId,
				merchandise__c  = merchandiseId,
				unit_price__c	= price,
				quantity__c		= quantitySold
			); 
		try { insert lineItem; }
		catch (DmlException e) { throw new WARE_LineItemException('Line item could not be inserted.', e); }
	}
	
	private static Id createInvoice(Merchandise__c merchandise, String productDescription, Integer productSold)
	{
		Invoice__c invoice = new Invoice__c(Description__C = productDescription);		
			insert invoice;																// Add a new invoice														
		
		try 
		{ 
				addLineItem(invoice.id, merchandise.id, merchandise.price__c, productSold); 	// Add a new line item to the invoice
				merchandise.quantity__c -= productSold; 										// Update the inventory of the merchandise item			  
				update merchandise;
				return invoice.id;
		}
		catch (WARE_LineItemException lie) 
		{
			 WARE_WarehouseException.debug(lie);
			 throw new WARE_InvoiceException('Invoice could not be inserted.', lie); 
		}
	}
	
	public static Id createInvoice (String productName, Integer productSold, String productDescription)
	{
		// Retrieve the products sample merchandise
		Merchandise__c merchandise = [
										SELECT price__c, quantity__c
										FROM Merchandise__c
										WHERE name = :productName
										LIMIT 1
									];
		System.assertNotEquals(null, merchandise);										// break if no merchandise is found
		
		return createInvoice(merchandise, productDescription, productSold);
	}
}