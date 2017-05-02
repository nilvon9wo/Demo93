/**
 * Exception Handling example
 * @see Apex Workbook, page 46.
 **/
abstract public class WARE_WarehouseException extends Exception 
{
	public static void debug (WARE_WarehouseException we)
	{
		System.debug(LoggingLevel.ERROR, 'Message: '     + we.getMessage());
		System.debug(LoggingLevel.ERROR, 'Cause: ' 		 + we.getCause());
		System.debug(LoggingLevel.ERROR, 'Line number: ' + we.getLineNumber());
		System.debug(LoggingLevel.ERROR, 'Stack trace: ' + we.getStackTraceString());
	}
}