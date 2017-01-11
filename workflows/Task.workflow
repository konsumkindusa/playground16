<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Activity_Description_Hover</fullName>
        <description>This field will update the hover in the Account page layout.</description>
        <field>Activity_Description_Hover__c</field>
        <formula>LEFT( Activity_Descriptions__c , 50)</formula>
        <name>Update Activity Description Hover</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Activity_Description_Hover_2</fullName>
        <field>Activity_Description_Hover__c</field>
        <formula>LEFT( Notes_textarea__c , 50)</formula>
        <name>Update Activity Description Hover 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activity Description Hover - Log an Interaction</fullName>
        <actions>
            <name>Update_Activity_Description_Hover</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Activity_Descriptions__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow will update the Activity Description hover field in the Account page layout.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Activity Description Hover - Task</fullName>
        <actions>
            <name>Update_Activity_Description_Hover_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Notes_textarea__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow rule updates the Activity Description in the hovers on an Account.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
