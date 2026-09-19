%dw 2.0
output application/json
---
{
    ticketId: vars.cachedResult.ticketId,
    status: "DUPLICATE_CACHED",
    sentiment: vars.cachedResult.sentiment,
    urgency: vars.cachedResult.urgency,
    assignedPriority: vars.cachedResult.assignedPriority,
    caseNumber: vars.cachedResult.caseNumber,
    aiSummary: vars.cachedResult.aiSummary,
    routedQueue: vars.cachedResult.routedQueue,
    processedAt: vars.cachedResult.processedAt,
    cacheNote: "Ticket was previously processed. Returned from Mule Object Store cache."
}
