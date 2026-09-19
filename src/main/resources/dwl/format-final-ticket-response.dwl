%dw 2.0
output application/json
---
{
    ticketId: vars.classifiedTicket.ticketId,
    status: "PROCESSED",
    sentiment: vars.classifiedTicket.sentiment,
    urgency: vars.classifiedTicket.urgency,
    assignedPriority: vars.classifiedTicket.assignedPriority,
    caseNumber: payload.caseNumber default ("SF-" ++ (randomInt(89999) + 10000)),
    aiSummary: vars.classifiedTicket.aiSummary,
    routedQueue: vars.classifiedTicket.routedQueue,
    slaHours: vars.classifiedTicket.slaHours,
    isEscalated: vars.classifiedTicket.isEscalated,
    processedAt: now()
}
