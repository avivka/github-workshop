# Workshop 01: Organization-Wide Rulesets

In this exercise, you will learn how to manage repository governance at scale by creating Rulesets at the **Organization level**. This allows administrators to enforce policies across multiple repositories simultaneously.

## Repository Structure (Reference)

This workshop uses a monolithic repository structure to demonstrate path-based rules:
- `app/`: Application code.
- `prod/`: Production infrastructure.
- `qa/`: QA environment.

## Workshop Exercises

As an Organization Administrator, your task is to create several Rulesets that apply to specific repositories based on their names or properties.

### Exercise 1: DevOps Guard (Organization Level)
**Goal**: Enforce production protection across all repositories that contain infrastructure code.

1. Navigate to your **Organization Settings** -> **Code, planning, and automation** -> **Repository** -> **Rulesets**.
2. Create a new ruleset named **Org-Wide Prod Guard**.
3. **Target repositories**: Select "Target by name" and include your workshop repository (or "All repositories").
4. **Target branches**: Branch `main`.
5. **Targeting by bypass**: Add the `devops-team` to the bypass list.
6. **Conditions**: Add a "Restrict modifications" rule.
7. **Filters**: Use `fnmatch` to target production files:
   - `prod/**`
8. **Enforcement**: Set to "Active".

### Exercise 2: QA Isolation (Standardized Pathing)
**Goal**: Ensure QA teams can manage their environments without developer interference across the organization.

1. Create an organization ruleset named **Global QA Guard**.
2. **Target repositories**: Select your repository.
3. **Target branches**: Branch `main`.
4. **Targeting by bypass**: Add `qa-team` and `devops-team` to the bypass list.
5. **Conditions**: Add a "Restrict modifications" rule.
6. **Filters**: Use `fnmatch`:
   - `qa/**`

### Exercise 3: Enterprise-Wide PR Policy
**Goal**: Establish a baseline security posture by requiring PR reviews for all repositories in the organization.

1. Create an organization ruleset named **Enterprise PR Baseline**.
2. **Target repositories**: Select "All repositories".
3. **Target branches**: Branch `main`.
4. **Rule**: Require Pull Request.
5. **Sub-rule**: Require at least 1 approval.
6. **Goal**: This ensures that even "shadow IT" or newly created repos follow the organization's quality standards from day one.

### Exercise 4: Restricting Application Pushes (QA Restriction)
**Goal**: Prevent the QA team from pushing directly to application code.

1. Create an organization ruleset named **App Code Guard**.
2. **Targeting by bypass**: Add `dev-team` and `devops-team`. (Do NOT add `qa-team`).
3. **Conditions**: Add a "Restrict modifications" rule.
4. **Filters**: Use `fnmatch`:
   - `app/**`

---

## Admin Tip: Ruleset Precedence
When rulesets are created at both the Organization and Repository levels:
- **Both apply**: The rules are additive.
- **Most restrictive wins**: If an Org ruleset requires 2 approvals and a Repo ruleset requires 1, then **2 approvals** are required.
- **Admins cannot bypass Org rules**: Unless explicitly added to the Org-level bypass list.
