public with sharing class WarehouseDataInstall {

    public WarehouseDataInstall() {}

    public static boolean getHasData() {
        return [SELECT Id from Merchandise__c].size() > 0;
    }
    
    public PageReference createData() {
        List<Merchandise__c> m = new List<Merchandise__c>();
        m.add(new Merchandise__c(Name='Laptop',Price__c=500,Quantity__c=1000, Description__c='A Laptop is a portable personal computer with a clamshell form factor, suitable for mobile use.'));
        m.add(new Merchandise__c(Name='Desktop',Price__c=1000,Quantity__c=500, Description__c='A desktop computer is a personal computer in a form intended for regular use at a single location, as opposed to a mobile laptop or portable computer.'));
        m.add(new Merchandise__c(Name='Tablet',Price__c=300,Quantity__c=5000, Description__c='A tablet computer, or simply tablet, is a one-piece mobile computer. Devices typically have a touchscreen, with finger or stylus gestures replacing the conventional computer mouse.'));
        m.add(new Merchandise__c(Name='Rack Server',Price__c=3245.99,Quantity__c=500, Description__c='Dense, 4-socket server features a streamlined design, optimized for price and performance, with advanced flexibility and expandability.'));
        m.add(new Merchandise__c(Name='Old Laptop',Price__c=345.99,Quantity__c=50, Description__c='1)DELL LAPTOP WITH CHARGER,WEBCAM AND LAPTOP BAG; 2)RATING-3.1 WINDOWS EXPERIENCES INDEX; 3)PROCESSOR-PENTIUM(R)  DUAL CORE CPU of n; SERIES; 4)RAM-2GB; 5)SYSTEM TYPE-32 BIT OPERATING SYSTEM: WINDOW 7 ULTIMATE'));
        m.add(new Merchandise__c(Name='Deluxe Desktop',Price__c=1399.99,Quantity__c=250, Description__c='Xandros Desktop is a beautifully crafted operating system by a staff of meticulous and talented human beings.'));
        m.add(new Merchandise__c(Name='Work Desktop',Price__c=1145.99,Quantity__c=750, Description__c='Windows 7 Professional, Dell 745 Optiplex Desktop Computer, Featuring Powerful & Efficient Intel 3.4GHz Pentium D Dual Core CPU Processor, 500GB Ultra Fast 7200 RPM SATA hard drive, and CDRWRW/DVDRW SATA Ultra Speed Drive'));        
        insert m;
        
        for (Integer i=0; i<=6; i++) {
            Invoice__c inv = new Invoice__c(Status__c=(i < 3 ? 'Closed' : 'Open'));
            insert inv;
            
            Line_Item__c li = new Line_Item__c
              (Name='i', Quantity__c=1, Merchandise__c=m[i].Id,Invoice__c=inv.Id);
            insert li;       
        }
       
        
        return null;
    }
    
    
    @isTest
    public static void testWarehouseDataInstall() {
        WarehouseDataInstall wdi = new WarehouseDataInstall();
        if(!WarehouseDataInstall.getHasData()) {
            wdi.createData();
        }
        System.assertEquals(true,WarehouseDataInstall.getHasData());
    }

}