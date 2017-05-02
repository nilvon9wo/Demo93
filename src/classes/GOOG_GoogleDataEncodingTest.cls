/**
 * This class contains unit tests for the encoding algorithm for use with the Google chart API.
 **/
 @isTest
public class GOOG_GoogleDataEncodingTest 
{
	private static final Integer TEST_MIN = 0; 
	private static final Integer TEST_MAX = 100; 

	public static GOOG_GoogleDataEncoding createDummy(GOOG_GoogleDataEncoding.EncodingType eType) { return new GOOG_GoogleDataEncoding(eType); }
	public static GOOG_GoogleDataEncoding createDummy() { return createDummy(GOOG_GoogleDataEncoding.EncodingType.SIMPLE); }

	public static void getEncodingDescriptorTest (GOOG_GoogleDataEncoding.EncodingType eType, String expectedChar)
	{
		GOOG_GoogleDataEncoding dataEncoding = null;
		Boolean encodingExceptionCaught = false;
		
		try 
		{ 
			dataEncoding = createDummy(eType);
			String descriptor = dataEncoding.getEncodingDescriptor();
			System.assertEquals (expectedChar, descriptor); 
		}
		catch (GOOG_UnsupportedEncodingTypeException e){ encodingExceptionCaught = true; }
				
		if (eType != GOOG_GoogleDataEncoding.EncodingType.SIMPLE ) { System.assert (encodingExceptionCaught); }
	}
	
	private static testMethod void getSimpleEncodingDescriptor() 		{ getEncodingDescriptorTest (GOOG_GoogleDataEncoding.EncodingType.SIMPLE, 's'); }

	// These are not supported yet!
	private static testMethod void getTextEncodingDescriptor() 			{ getEncodingDescriptorTest (GOOG_GoogleDataEncoding.EncodingType.TEXT, 't'); }
	private static testMethod void getExtenedEncodingDescriptor() 		{ getEncodingDescriptorTest (GOOG_GoogleDataEncoding.EncodingType.EXTENDED, 'e'); }
	private static testMethod void getUnsupportedEncodingDescriptor() 	{ getEncodingDescriptorTest (GOOG_GoogleDataEncoding.EncodingType.UNSUPPORTED, ''); }

	public static void getEncodeTest (Integer dataPoint, String expectedChar)
	{
		GOOG_GoogleDataEncoding dataEncoding = createDummy();
		
		String encoding = null;
		Boolean encodingExceptionCaught = false;
		
		try  { encoding =  dataEncoding.getEncode(dataPoint); }
		catch (GOOG_EncodingException e){ encodingExceptionCaught = true; }
				
		if (dataPoint >= GOOG_GoogleDataEncoding.ENCODING_MIN && dataPoint <= GOOG_GoogleDataEncoding.ENCODING_MAX) 
		{ 
			System.assertEquals (expectedChar, encoding);
		}
		else { System.assert (encodingExceptionCaught); }
		
	}
	
	private static testMethod void getNegativeEncodeTest()	{ getEncodeTest (GOOG_GoogleDataEncoding.ENCODING_MIN - 1, '!'); }
	private static testMethod void get00EncodeTest()		{ getEncodeTest (0,'A');}
	private static testMethod void get01EncodeTest()		{ getEncodeTest (1,'B');}
	private static testMethod void get02EncodeTest()		{ getEncodeTest (2,'C');}
	private static testMethod void get03EncodeTest()		{ getEncodeTest (3,'D');}
	private static testMethod void get04EncodeTest()		{ getEncodeTest (4,'E');}
	private static testMethod void get05EncodeTest()		{ getEncodeTest (5,'F');}
	private static testMethod void get06EncodeTest()		{ getEncodeTest (6,'G');}
	private static testMethod void get07EncodeTest()		{ getEncodeTest (7,'H');}
	private static testMethod void get08EncodeTest()		{ getEncodeTest (8,'I');}
	private static testMethod void get09EncodeTest()		{ getEncodeTest (9,'J');}
	private static testMethod void get10EncodeTest()		{ getEncodeTest (10,'K');}
	private static testMethod void get11EncodeTest()		{ getEncodeTest (11,'L');}
	private static testMethod void get12EncodeTest()		{ getEncodeTest (12,'M');}
	private static testMethod void get13EncodeTest()		{ getEncodeTest (13,'N');}
	private static testMethod void get14EncodeTest()		{ getEncodeTest (14,'O');}
	private static testMethod void get15EncodeTest()		{ getEncodeTest (15,'P');}
	private static testMethod void get16EncodeTest()		{ getEncodeTest (16,'Q');}
	private static testMethod void get17EncodeTest()		{ getEncodeTest (17,'R');}
	private static testMethod void get18EncodeTest()		{ getEncodeTest (18,'S');}
	private static testMethod void get19EncodeTest()		{ getEncodeTest (19,'T');}
	private static testMethod void get20EncodeTest()		{ getEncodeTest (20,'U');}
	private static testMethod void get21EncodeTest()		{ getEncodeTest (21,'V');}
	private static testMethod void get22EncodeTest()		{ getEncodeTest (22,'W');}
	private static testMethod void get23EncodeTest()		{ getEncodeTest (23,'X');}
	private static testMethod void get24EncodeTest()		{ getEncodeTest (24,'Y');}
	private static testMethod void get25EncodeTest()		{ getEncodeTest (25,'Z');}
	private static testMethod void get26EncodeTest()		{ getEncodeTest (26,'a');}
	private static testMethod void get27EncodeTest()		{ getEncodeTest (27,'b');}
	private static testMethod void get28EncodeTest()		{ getEncodeTest (28,'c');}
	private static testMethod void get29EncodeTest()		{ getEncodeTest (29,'d');}
	private static testMethod void get30EncodeTest()		{ getEncodeTest (30,'e');}
	private static testMethod void get31EncodeTest()		{ getEncodeTest (31,'f');}
	private static testMethod void get32EncodeTest()		{ getEncodeTest (32,'g');}
	private static testMethod void get33EncodeTest()		{ getEncodeTest (33,'h');}
	private static testMethod void get34EncodeTest()		{ getEncodeTest (34,'i');}
	private static testMethod void get35EncodeTest()		{ getEncodeTest (35,'j');}
	private static testMethod void get36EncodeTest()		{ getEncodeTest (36,'k');}
	private static testMethod void get37EncodeTest()		{ getEncodeTest (37,'l');}
	private static testMethod void get38EncodeTest()		{ getEncodeTest (38,'m');}
	private static testMethod void get39EncodeTest()		{ getEncodeTest (39,'n');}
	private static testMethod void get40EncodeTest()		{ getEncodeTest (40,'o');}
	private static testMethod void get41EncodeTest()		{ getEncodeTest (41,'p');}
	private static testMethod void get42EncodeTest()		{ getEncodeTest (42,'q');}
	private static testMethod void get43EncodeTest()		{ getEncodeTest (43,'r');}
	private static testMethod void get44EncodeTest()		{ getEncodeTest (44,'s');}
	private static testMethod void get45EncodeTest()		{ getEncodeTest (45,'t');}
	private static testMethod void get46EncodeTest()		{ getEncodeTest (46,'u');}
	private static testMethod void get47EncodeTest()		{ getEncodeTest (47,'v');}
	private static testMethod void get48EncodeTest()		{ getEncodeTest (48,'w');}
	private static testMethod void get49EncodeTest()		{ getEncodeTest (49,'x');}
	private static testMethod void get50EncodeTest()		{ getEncodeTest (50,'y');}
	private static testMethod void get51EncodeTest()		{ getEncodeTest (51,'z');}
	private static testMethod void get52EncodeTest()		{ getEncodeTest (52,'0');}
	private static testMethod void get53EncodeTest()		{ getEncodeTest (53,'1');}
	private static testMethod void get54EncodeTest()		{ getEncodeTest (54,'2');}
	private static testMethod void get55EncodeTest()		{ getEncodeTest (55,'3');}
	private static testMethod void get56EncodeTest()		{ getEncodeTest (56,'4');}
	private static testMethod void get57EncodeTest()		{ getEncodeTest (57,'5');}
	private static testMethod void get58EncodeTest()		{ getEncodeTest (58,'6');}
	private static testMethod void get59EncodeTest()		{ getEncodeTest (59,'7');}
	private static testMethod void get60EncodeTest()		{ getEncodeTest (60,'8');}
	private static testMethod void get61EncodeTest()		{ getEncodeTest (61,'9');}
	private static testMethod void getTooHighEncodeTest()	{ getEncodeTest (GOOG_GoogleDataEncoding.ENCODING_MAX + 1, '!'); }
	
	public static void getEncodedChartTest (String graphString, String expectedString)
	{
		GOOG_GoogleDataEncoding dataEncoding = createDummy();
		
		String chartCode = null;
		Boolean encodingExceptionCaught = false;
		
		try { chartCode = dataEncoding.getEncodedChart(graphString); }
		catch (GOOG_EncodingException e){ encodingExceptionCaught = true; }

		if ((new Set<String>{'barChart', 'lineChart'}).contains(graphString))
		{
			System.assertEquals (expectedString, chartCode); 
		}
		else { System.assert (encodingExceptionCaught); }
	}

	private static testMethod void getEncodedBarChartTest()		{ getEncodedChartTest ('barChart','bvs');}
	private static testMethod void getEncodedLineChartTest()	{ getEncodedChartTest ('lineChart','ls');}
	private static testMethod void getEncodedOtherChartTest()	{ getEncodedChartTest ('otherChart', '!'); }


}