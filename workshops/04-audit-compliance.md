# Workshop 04: Audit & Compliance

In this workshop, you will assume the role of a Security Analyst investigating a "data leak" incident using GitHub Enterprise Audit Logs.

## Scenario
**Incident Report**: On Jan 8th, our monitoring systems detected that the `workshop-app` repository was briefly exposed to the public internet. 
**Objective**: Identify who made the change, when it happened, and what corrective actions were taken.

## Material
- `audit-samples/incident-log.json`: A raw export of the organization's audit log during the incident window.

## Exercises

### Exercise 1: The Investigation
**Goal**: Analyze the log file to reconstruct the timeline.

1. Open `audit-samples/incident-log.json`.
2. Search for the action `repo.change_visibility`.
3. **Question**: Who changed the repository from `private` to `public`? 
   - *Answer*: Check the `actor` field for that event.
4. **Question**: How long was the repository public?
   - *Hint*: Find the subsequent `repo.change_visibility` event where it went back to `private`. Calculate the difference between the timestamps.

### Exercise 2: Using the Audit Log UI
**Goal**: Learn how to filter real audit logs in the GitHub UI.

1. Navigate to **Organization Settings** -> **Archives** -> **Logs** -> **Audit Log**.
2. **Search Syntax**: Try the following queries to filter noise:
   - `action:repo.change_visibility` - Finds all visibility changes.
   - `actor:YOUR_USERNAME` - Finds everything you did today.
   - `action:protected_branch.deleted` - Crucial for finding "rogue" admin bypasses.

### Exercise 3: Log Streaming (Conceptual)
**Goal**: Understand long-term compliance retention.

For enterprise environments, logs are typically retained for 90 days. For compliance (SOC2, HIPAA), you often need 1+ years.
1. Navigate to **Organization Settings** -> **Audit Log** -> **Streams**.
2. **Action**: Explain that in a real environment, you would configure a stream to **Splunk**, **Datadog**, or **Azure Monitor**.
3. **Benefit**: Streaming allows you to set up *real-time alerts* (e.g., "Alert me immediately if a private repo becomes public").

### Exercise 4: Accessing GitHub's Compliance Reports
**Goal**: Download GitHub's official compliance reports (e.g., SOC2, ISO 27001) for your own auditors.

1. Navigate to **Organization Settings** -> **Compliance**.
2. **locate the report**: Browse the list of available reports (SOC2 Type II, ISO 27001, FedRAMP, etc.).
3. **Download**: Select the report you need.
   - *Note*: You may need to sign a nondisclosure agreement (NDA) before downloading specific reports.
4. **Usage**: Provide these reports to your internal compliance team to prove that your vendor (GitHub) is secure.

---

## Key Takeaways
- **Everything is Logged**: From git pushes to setting changes, GitHub records the Actor, Action, and IP.
- **Search Syntax**: Mastering the `key:value` search syntax is critical for fast investigations.
- **Streaming is Mandatory**: For any regulated industry, rely on streaming logs to a SIEM.
- **Vendor Assurance**: Use the **Compliance** tab to retrieve GitHub's own security attestations.
