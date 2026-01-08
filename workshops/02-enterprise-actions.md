# Workshop 02: Enterprise Actions Management

In this workshop, you will learn how to manage and scale GitHub Actions at the enterprise level, focusing on standardization and policy enforcement.

## Objectives
1. Understand the difference between **Composite Actions** and **Reusable Workflows**.
2. Learn how to centralize CI/CD logic to ensure compliance across the organization.
3. Configure organization-level policies for allowed actions.

## Repository Components
- `shared-actions/composite-build/action.yml`: A standardized build step that can be used inside jobs.
- `.github/workflows/reusable-build.yml`: A complete pipeline that can be called by other workflows.

## Exercises

### Exercise 1: Exploring Reusable Components
**Goal**: Understand how reusable actions and workflows reduce duplication.

1. Review the composite action at `shared-actions/composite-build/action.yml`. 
2. Review the reusable workflow at `.github/workflows/reusable-build.yml`.
3. Notice how the reusable workflow calls the composite action. This "nested" reuse is a common pattern for large enterprises.

### Exercise 2: Implementing a Standardized Pipeline
**Goal**: Create a repository workflow that calls the organization's reusable pipeline.

1. Create a new file in your repository: `.github/workflows/app-ci.yml`.
2. instead of writing the full job logic, use the `uses` keyword to call the reusable workflow:
   ```yaml
   name: App CI
   on:
     pull_request:
       branches: [main]
   jobs:
     call-reusable:
       uses: ./.github/workflows/reusable-build.yml
       with:
         python-version: '3.11'
         run-tests: true
   ```

### Exercise 3: Admin Governance (Conceptual)
**Goal**: Learn how to enforce these patterns as an administrator.

1. **Policy Enforcement**: Discuss how to use **GitHub Actions Policies** to restrict repositories to *only* allowed internal actions or verified partners.
2. **Immutable Versions**: Explain the importance of pinning actions to a specific commit SHA (e.g., `uses: actions/checkout@b4ffde65f46336ab88eb53be808477a3936bae11`) to prevent supply chain attacks.
3. **Internal Actions**: Discuss how to set up an "Internal Actions" repository to share code across the entire GitHub Enterprise.

---

## Key Takeaways
- **Composite Actions**: Best for grouping multiple steps into a single action. Great for internal branding (e.g., `company-build`).
- **Reusable Workflows**: Best for standardizing entire pipelines (e.g., "The official Python CI pipeline").
- **Scaling**: Admins should encourage teams to "stop writing YAML" and instead "consume standardized workflows".
