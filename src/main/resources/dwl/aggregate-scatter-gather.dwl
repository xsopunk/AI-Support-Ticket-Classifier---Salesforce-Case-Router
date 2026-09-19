%dw 2.0
output application/json
---
{
    aiResult: payload["0"].payload,
    auditRecord: payload["1"].payload,
    aggregatedAt: now()
}
