/**
 * This class contains the encoding algorithm for use with the Google chart API.
 **/
public class GOOG_GoogleDataEncoding 
{
	public static final Integer ENCODING_MIN = 0;	// The minimum encoding value supported for the given encoding type.
	public static final Integer ENCODING_MAX = 61;	// The maximum encoding value supported for the given encoding type.

	// The ecoding types according to Google's API.  Only SIMPLE is implemented herein (as of 2013 August 1).
	public enum EncodingType { TEXT, SIMPLE, EXTENDED, UNSUPPORTED }

	// Semi-public variables
	public  GOOG_GoogleDataEncoding.EncodingType eType 	{ get; private set; }	// The encoding type according to the API defined by Google.

	// Values initialized in init()
	private Map<Integer, String> 	encodingMap 	{ get; set; }			// The encoding map which takes an integer key and returns the respective encoding value as defined by Google.

	/**
	 * Class constructor
	 * @param Integer min
	 * @param Integer max
	 * @param EncodingType eType
	 * @return None
	 **/
	public GOOG_GoogleDataEncoding(EncodingType eType)
	{
		this.eType 		 = eType;
		init();
	}

	/** 
	 * This method initializes the encoding map which is then stored for expected reptitious use to minimize statement invocation.
	 **/
	private void init() 
	{
		if (eType == EncodingType.SIMPLE)
		{
            encodingMap = new Map<Integer, String>();
            encodingMap.put(0,'A');
            encodingMap.put(1,'B');
            encodingMap.put(2,'C');
            encodingMap.put(3,'D');
            encodingMap.put(4,'E');
            encodingMap.put(5,'F');
            encodingMap.put(6,'G');
            encodingMap.put(7,'H');
            encodingMap.put(8,'I');
            encodingMap.put(9,'J');
            encodingMap.put(10,'K');
            encodingMap.put(11,'L');
            encodingMap.put(12,'M');
            encodingMap.put(13,'N');
            encodingMap.put(14,'O');
            encodingMap.put(15,'P');
            encodingMap.put(16,'Q');
            encodingMap.put(17,'R');
            encodingMap.put(18,'S');
            encodingMap.put(19,'T');
            encodingMap.put(20,'U');
            encodingMap.put(21,'V');
            encodingMap.put(22,'W');
            encodingMap.put(23,'X');
            encodingMap.put(24,'Y');
            encodingMap.put(25,'Z');
            encodingMap.put(26,'a');
            encodingMap.put(27,'b');
            encodingMap.put(28,'c');
            encodingMap.put(29,'d');
            encodingMap.put(30,'e');
            encodingMap.put(31,'f');
            encodingMap.put(32,'g');
            encodingMap.put(33,'h');
            encodingMap.put(34,'i');
            encodingMap.put(35,'j');
            encodingMap.put(36,'k');
            encodingMap.put(37,'l');
            encodingMap.put(38,'m');
            encodingMap.put(39,'n');
            encodingMap.put(40,'o');
            encodingMap.put(41,'p');
            encodingMap.put(42,'q');
            encodingMap.put(43,'r');
            encodingMap.put(44,'s');
            encodingMap.put(45,'t');
            encodingMap.put(46,'u');
            encodingMap.put(47,'v');
            encodingMap.put(48,'w');
            encodingMap.put(49,'x');
            encodingMap.put(50,'y');
            encodingMap.put(51,'z');
            encodingMap.put(52,'0');
            encodingMap.put(53,'1');
            encodingMap.put(54,'2');
            encodingMap.put(55,'3');
            encodingMap.put(56,'4');
            encodingMap.put(57,'5');
            encodingMap.put(58,'6');
            encodingMap.put(59,'7');
            encodingMap.put(60,'8');
            encodingMap.put(61,'9');
		}
		else { throw new GOOG_UnsupportedEncodingTypeException ('Type provided ' + eType + ' is not supported yet.'); }
	}

	// public methods -----------------------------------------------------------------------------------------------------------------------------
	
	
	/**
	 * This method returns the encoding type parameter value that matches the specified encoding type.
	 * @param EncodingType eType : the specified encoding type
	 * @return String : a string representing the encoding descriptor
	 **/
	 public String getEncodingDescriptor ()
	 {
	 	return (this.eType == EncodingType.TEXT)
	 			? 't'
	 			: (this.eType == EncodingType.SIMPLE)
	 				? 's'
	 				: (this.eType == EncodingType.EXTENDED)
	 					? 'e'
	 					: '';
	 }
	 
	 /**
	  *	This method takes a given number within the declared range of the encoding class and encodes it according to the encoding type.
	  * If the value provided fall outside of the declared range, an EncodingException is thrown.
	  * @param Integer dataPoint : the data point to plot
	  * @return String : the encoded value.
	  **/
	  public String getEncode(Integer dataPoint) 
	  { 
	  	if (dataPoint < ENCODING_MIN || dataPoint > ENCODING_MAX) 
	  	{ 
	  		throw new GOOG_EncodingException ('Value provided ' + dataPoint + ' was outside the declared min/max range (' + ENCODING_MIN + '/' + ENCODING_MAX + ')');
	  	}	 
	  	else return encodingMap.get(dataPoint);
	  }


  	  public String getEncodedChart(String graphString)
	  {
	  		Map<String,String> chartMap = new Map<String,String>
								{
									'barChart'  => 'bvs',
									'lineChart' => 'ls'
								};
		   if (chartMap.keySet().contains(graphString)) { return chartMap.get(graphString); }			
           else { throw new GOOG_EncodingException ('An unsupported chart type was selected: ' + graphString + ' does not exist.'); }			
	  }
}