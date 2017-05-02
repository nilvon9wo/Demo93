<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>Album_Price_Outbound_Alert</fullName>
        <apiVersion>28.0</apiVersion>
        <endpointUrl>http://requestb.in/p0j0t7p0</endpointUrl>
        <fields>Id</fields>
        <fields>Name</fields>
        <fields>Price__c</fields>
        <fields>SystemModstamp</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>flux@nowhereatall.net</integrationUser>
        <name>Album Price Outbound Alert</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Expensive Album Alert</fullName>
        <actions>
            <name>Album_Price_Outbound_Alert</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Album__c.Price__c</field>
            <operation>greaterThan</operation>
            <value>20</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
