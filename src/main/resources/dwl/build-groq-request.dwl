%dw 2.0
output application/json
---
{
    model: p('groq.model') default "llama-3.3-70b-versatile",
    messages: [
        {
            role: "system",
            content: "You are an enterprise customer support AI classifier. Analyze the provided ticket and output ONLY valid JSON in this exact schema: {\"sentiment\": \"Angry\" | \"Frustrated\" | \"Neutral\" | \"Satisfied\", \"urgency\": \"Critical\" | \"High\" | \"Medium\" | \"Low\", \"aiSummary\": \"one sentence summary\", \"suggestedAction\": \"recommended support action\"}."
        },
        {
            role: "user",
            content: "Ticket ID: " ++ (payload.ticketId default "") ++ "\nCustomer: " ++ (payload.customerName default "") ++ "\nSubject: " ++ (payload.subject default "") ++ "\nDescription: " ++ (payload.description default "")
        }
    ],
    temperature: 0.1,
    response_format: {
        "type": "json_object"
    }
}
