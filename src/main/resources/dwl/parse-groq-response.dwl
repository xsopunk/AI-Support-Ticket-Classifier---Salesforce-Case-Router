%dw 2.0
output application/json

var rawContent = payload.choices[0].message.content default "{}"
var aiResult = read(rawContent, "application/json") default {}

---
{
    sentiment: if (["Angry", "Frustrated", "Neutral", "Satisfied"] contains aiResult.sentiment) aiResult.sentiment else "Neutral",
    urgency: if (["Critical", "High", "Medium", "Low"] contains aiResult.urgency) aiResult.urgency else "Medium",
    aiSummary: aiResult.aiSummary default (vars.originalTicket.subject default "Support ticket submitted"),
    suggestedAction: aiResult.suggestedAction default "Assign to standard queue",
    aiProvider: "Groq-LLaMA-3.3-70b",
    classifiedAt: now()
}
