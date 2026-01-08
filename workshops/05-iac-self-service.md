# Workshop 05: Terraform & Self-Service

In this workshop, you will build a "Repo Factory" using Infrastructure as Code (Terraform) and GitHub Actions. This pattern allows organizations to vend standardized repositories to development teams automatically.

## Objectives
1. Create a "Golden Template" repository.
2. Write Terraform code to provision new repositories from that template.
3. Automate the process using a GitHub Actions `workflow_dispatch` trigger.

## Exercises

### Exercise 1: Create the Golden Template
**Goal**: Create a clean, compliant repository that will serve as the base for all new microservices.

1. Create a **new repository** in your organization named `microservice-template`.
2. Add a `README.md` and some standardized files (e.g., a `.gitignore`, a `CODEOWNERS` file).
3. Navigate to **Settings** -> **General**.
4. Check the box **"Template repository"**.

### Exercise 2: The Infrastructure as Code (Terraform)
**Goal**: Review the Terraform code that defines how a repository is created.

1. Examine `terraform/main.tf` in *this* workshop repository.
   - Notice the `github_repository` resource.
   - Notice the `template` block which references the `template_repo` variable.
2. Examine `terraform/variables.tf`.
   - Creating a repo requires inputs: `repo_name` and `template_repo`.

### Exercise 3: The Automation Workflow
**Goal**: execute the Terraform via GitHub Actions.

1. Navigate to the **Actions** tab of *this* workshop repository.
2. Select the **Create Repo from Template** workflow.
3. Click **Run workflow**.
4. **Inputs**:
   - `new_repo_name`: `my-service-v1` (or any unique name).
   - `template_repo`: `microservice-template` (the one you created in Exercise 1).
5. **Run**.

> [!IMPORTANT]
> **Permission Note**: To create repositories, the Action needs a **Personal Access Token (PAT)** or an App Token with `repo` scope, stored as a secret named `GH_PAT`. The standard `GITHUB_TOKEN` typically does not have permissions to create *new* repositories in the organization.

6. Once the job succeeds, navigate to your organization's home page and verify that `my-service-v1` exists and contains the files from `microservice-template`.

---

## Key Takeaways
- **Self-Service**: By wrapping Terraform in GitHub Actions, you allow developers to create compliant infrastructure without being Org Admins.
- **Standardization**: Every new repo starts with the correct `CODEOWNERS`, labels, and branch protections (if you expand the Terraform).
- **GitOps**: You can extend this to manage the Terraform state remotely, tracking every repository creation in a central valid state.
