/**
 * @description Class to help dummy factories choose between config values and default values.
 * @author      Brian Kessler <Brian_Kessler@epam.com>
 * @date        2013 July 18
 **/
 @isTest
public class TEST_ConfigHelper 
{
    /** 
    * @description  Method to choose between Strings.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        String configValue  : Value from Config (Inner Class) 
    * @param        String defaultValue : Value to use as default (if Config value is null);
    * @return       String
    **/
    public static String chooseValue(String configValue, String defaultValue)
    {
        return (configValue != null)
                ? configValue
                : defaultValue;
    }

    /** 
    * @description  Method to choose between Integer.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Integer configValue  : Value from Config (Inner Class) 
    * @param        Integer defaultValue : Value to use as default (if Config value is null);
    * @return       Integer
    **/
    public static Integer chooseValue(Integer configValue, Integer defaultValue)
    {
        return (configValue != null)
                ? configValue
                : defaultValue;
    }

    /** 
    * @description  Method to choose between Double.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        Double configValue  : Value from Config (Inner Class) 
    * @param        Double defaultValue : Value to use as default (if Config value is null);
    * @return       Double
    **/
    public static Double chooseValue(Double configValue, Double defaultValue)
    {
        return (configValue != null)
                ? configValue
                : defaultValue;
    }

    /** 
    * @description  Method to choose between Date.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 August 13
    * @param        Date configValue  : Value from Config (Inner Class) 
    * @param        Date defaultValue : Value to use as default (if Config value is null);
    * @return       Date
    **/
    public static Date chooseValue(Date configValue, Date defaultValue)
    {
        return (configValue != null)
                ? configValue
                : defaultValue;
    }

    /** 
    * @description  Method to choose between sObject.
    * @author       Brian Kessler <Brian_Kessler@epam.com>
    * @date         2013 July 18
    * @param        sObject configValue  : Value from Config (Inner Class) 
    * @param        sObject defaultValue : Value to use as default (if Config value is null);
    * @return       sObject
    **/
    public static sObject chooseValue(sObject configValue, sObject defaultValue)
    {
        return (configValue != null)
                ? configValue
                : defaultValue;
    }

}