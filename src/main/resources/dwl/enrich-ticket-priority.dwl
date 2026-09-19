%dw 2.0
output application/json
---
{
    ticketId: vars.originalTicket.ticketId,
    customerName: vars.originalTicket.customerName,
    email: vars.originalTicket.email,
    subject: vars.originalTicket.subject,
    description: vars.originalTicket.description,
    category: vars.originalTicket.category default "General",
    sentiment: vars.aiAnalysis.sentiment default "Neutral",
    urgency: vars.aiAnalysis.urgency default "Medium",
    aiSummary: vars.aiAnalysis.aiSummary default vars.originalTicket.subject,
    suggestedAction: vars.aiAnalysis.suggestedAction default "Standard review",
    assignedPriority: vars.routingDetails.assignedPriority,
    routedQueue: vars.routingDetails.routedQueue,
    slaHours: vars.routingDetails.slaHours,
    isEscalated: vars.routingDetails.isEscalated,
    classifiedAt: now()
}
