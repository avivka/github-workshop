# Workshop 03: Enterprise Security Strategy

In this workshop, you will learn how to enforce a secure baseline across your organization using "Prevention" and "Visibility" policies. These settings are critical for preventing supply chain attacks and accidental secret leakage.

## Objectives
1. **Restrict Supply Chain Risks**: Configure policies to allow only trusted GitHub Actions.
2. **Prevent Data Leaks**: Enable organization-wide secret scanning and push protection.
3. **Gain Visibility**: Enable dependency insights to catch vulnerabilities early.

## Exercises

### Exercise 1: The "Firewall" (Actions Allow Lists)
**Goal**: Prevent malicious or unverified actions from running in your enterprise.

1. Navigate to **Organization Settings** -> **Actions** -> **General** -> **Actions policies**.
2. Select **Allow select actions and reusable workflows**.
3. Configure the following rules:
   - [x] Allow actions created by GitHub
   - [x] Allow actions by Marketplace verified creators
   - [ ] Allow specified actions and reusable workflows.
4. In the "specified actions" list, add your internal repo pattern:
   - `YOUR_ORG/workshop-repo/*` (Allows your internal reusable workflows).
5. **Save**. Now, try to create a workflow that uses an unverified action (e.g., a random user's action) and watch it fail.

### Exercise 2: The "Safety Net" (Secret Scanning)
**Goal**: Stop secrets (API keys, tokens) from ever entering your codebase.

1. Navigate to **Organization Settings** -> **Code security and analysis**.
2. Under **Secret scanning**, click **Enable all**.
3. Check the box for **"Automatically enable for new repositories"**.
4. Enable **Push protection**.
5. **Test it**: Try to commit a fake AWS key to a file in your repository.
   - Example fake key: `AKIAIMNOJVGFDEXAMPLE`
   - Git should reject the push.

### Exercise 3: Supply Chain Visibility
**Goal**: Automatically identify known vulnerabilities in your dependencies.

1. Navigate to **Organization Settings** -> **Code security and analysis**.
2. Under **Dependency graph**, click **Enable all**.
3. Under **Dependabot alerts**, click **Enable all**.
4. **Result**: GitHub will now scan `app/requirements.txt` and `package.json` files across the org and alert you to vulnerabilities.

---

## Admin Key Takeaways
- **Secure by Default**: Use the "Enable all" buttons to ensure no repository is left unprotected.
- **Least Privilege**: Start with a restrictive Actions policy and only allow specific actions as needed.
- **Prevention > Remediation**: Push protection is cheaper than rotating leaked keys.
