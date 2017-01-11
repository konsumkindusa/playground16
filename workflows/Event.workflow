<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Activity_Description_Hover_3</fullName>
        <field>Activity_Description_Hover__c</field>
        <formula>LEFT ( Description , 50)</formula>
        <name>Update Activity Description Hover 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Activity Description Hover - Events</fullName>
        <actions>
            <name>Update_Activity_Description_Hover_3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Description</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow rule updates the Activity description hover for Events.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
