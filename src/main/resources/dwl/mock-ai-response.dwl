%dw 2.0
output application/json

var text = lower((vars.originalTicket.subject default "") ++ " " ++ (vars.originalTicket.description default ""))

var isCritical = text contains "emergency" or text contains "outage" or text contains "data loss" or text contains "hacked"
var isHigh = text contains "urgent" or text contains "charged twice" or text contains "refund" or text contains "broken" or text contains "cannot access"
var isAngry = text contains "angry" or text contains "furious" or text contains "terrible" or text contains "unacceptable" or text contains "charged twice" or text contains "immediately"

---
{
    sentiment: if (isAngry) "Angry" else if (isHigh or isCritical) "Frustrated" else "Neutral",
    urgency: if (isCritical) "Critical" else if (isHigh) "High" else "Medium",
    aiSummary: "Analyzed: " ++ (vars.originalTicket.subject default "Customer issue"),
    suggestedAction: if (isCritical) "Escalate to engineering on-call immediately" else if (isHigh) "Assign to senior specialist with 2-hour SLA" else "Assign to standard queue",
    aiProvider: "MuleSoft-Embedded-Heuristic-Engine",
    classifiedAt: now()
}
