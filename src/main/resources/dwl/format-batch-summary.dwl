%dw 2.0
output application/json
---
{
    batchJobInstanceId: payload.batchJobInstanceId default "BATCH-" ++ ((randomInt(89999) + 10000) as String),
    status: "COMPLETED",
    totalRecords: payload.totalRecords default 0,
    successfulRecords: payload.successfulRecords default 0,
    failedRecords: payload.failedRecords default 0,
    elapsedTimeInMillis: payload.elapsedTimeInMillis default 0,
    completedAt: now()
}
