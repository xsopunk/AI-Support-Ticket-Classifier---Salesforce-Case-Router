%dw 2.0
output application/json

var requiredFields = [
    if (isEmpty(payload.ticketId)) "ticketId is required" else null,
    if (isEmpty(payload.customerName)) "customerName is required" else null,
    if (isEmpty(payload.email)) "email is required" else null,
    if (!isEmpty(payload.email) and !(payload.email matches /^.+@.+\..+$/)) "email format is invalid" else null,
    if (isEmpty(payload.subject)) "subject is required" else null,
    if (isEmpty(payload.description)) "description is required" else null,
    if (!isEmpty(payload.description) and sizeOf(payload.description) < 10) "description must be at least 10 characters" else null
] filter (!isEmpty($))

---
{
    isValid: sizeOf(requiredFields) == 0,
    errors: requiredFields,
    ticket: if (sizeOf(requiredFields) == 0) {
        ticketId: payload.ticketId,
        customerName: payload.customerName,
        email: payload.email,
        subject: trim(payload.subject),
        description: trim(payload.description),
        category: payload.category default "General",
        submittedAt: payload.submittedAt default now()
    } else null
}
