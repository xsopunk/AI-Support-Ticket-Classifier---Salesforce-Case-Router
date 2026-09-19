%dw 2.0
output application/json
---
{
    Subject: payload.subject,
    Description: payload.description,
    Priority: if (payload.assignedPriority startsWith "P1") "Critical"
              else if (payload.assignedPriority startsWith "P2") "High"
              else if (payload.assignedPriority startsWith "P3") "Medium"
              else "Low",
    Status: "New",
    Origin: "Web Ingestion API",
    Type: payload.category default "General",
    SuppliedEmail: payload.email,
    SuppliedName: payload.customerName,
    CustomFields: {
        Sentiment__c: payload.sentiment,
        Urgency__c: payload.urgency,
        AI_Summary__c: payload.aiSummary,
        Target_Queue__c: payload.routedQueue,
        SLA_Hours__c: payload.slaHours,
        Is_Escalated__c: payload.isEscalated
    }
}
