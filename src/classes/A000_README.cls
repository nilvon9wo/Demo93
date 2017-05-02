/*
	This "class" does nothing except allow me to put some notes here. :-)
	
	I've been reviewing various tutorials, redoing them both for my own "training" and to potentially provide good examples to others.
	
	While I haven't always been diligent (i.e. neurotic) about providing comments, if browsing through these classes (and other metadata),
	it may help to understand the following Prefixes and Suffixes to the class names:
	
	* Prefixes
		- A000 - Means I just wanted to force a text file to the top of the directory
		
		- BAT  - Short for "Batch", examples of using Batch processing
		
		- COOK - Short for "Cookbook"; "|recipes derived from (but not identical to) developer.force.com/cookbook
		
		- FUND - Short for "Fundamental"; these examples show fundamentals of Apex programming (it is a lot like, but not the same as Java).
		
		- GOOG - Short for "Google"; examples of Google integration.
		
		- INT  - Short for "Integration"; demonstrates SFDC integration with Spring MVC Fulfillment Base.
					Derived from, but not identical to, code in SFDC's Integration Workbook
					
		- MOCK - Reference to "Mock Server"; examples of using mock servers to test integration functionality.
		
		- MORT - Short for "Mortgage"; example of using Apex in a Cloud Flow.
		
		- MUS  - Short for "Music", this example comes from the Database.com Workbook (but is also valid in SFDC).  
					It integrates with a Java Maven Project.
		
		- REST - These examples use Apex REST.
		
		- TEST - These classes exist exclusively to facilitate testing
		
		- TRIG - Short for "Trigger"; these classes estable an establish a foundation for trigger handling, which we prefer not to do in the actual 
					trigger, but rather within a handler class (e.g. INT_InvoiceTriggerHandler).
		
		- VF   - Short for "VisualForce", examples of VisualForce controllers
		
		- WARE - Short for "Warehouse"; this is example code related to SFDC's pervasive "Warehouse" application, 
					except the Java/Spring Integration (see "INT"). 
		
	* Suffixes
		- Controller - This class controls something; usually a VisualForce page or component (usually also specified in the name).
		
		- Factory - The class contains factory methods (such as for creating dummy records to unit test).
		
		- FlowProcess - This class contains code for a Flow process plugin implementation.
		
		- TriggerHandler - This class contains the actual code for handling triggers on the named sObject.
		
		- Test - This class contains unit tests for the class with the otherwise matching name.

*/
public class A000_README {}