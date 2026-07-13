# Roles and formation patterns

## Roles

| Role | Best use | Expected return |
|---|---|---|
| Shogun/Karo (lead) | Requirements, decomposition, integration, final verification | One coherent, verified result |
| Ashigaru: explorer | Codebase, document, data, or source discovery | Findings with paths, citations, and uncertainties |
| Ashigaru: implementer | A bounded implementation with exclusive file ownership | Changes made and tests run |
| Ashigaru: tester | Independent tests, reproduction, or validation | Commands, results, and failures |
| Gunshi: reviewer | Architecture, policy, risk, contradiction, or quality review | Prioritized issues and recommended decision |

## Recommended formations

### Software change

1. Explorer: map relevant code and constraints.
2. Implementer: own a bounded set of files.
3. Gunshi: review design, diff, and test coverage.

If implementation depends on exploration, run exploration first, then reuse the slot for implementation. Do not make dependent steps artificially parallel.

### Research or policy analysis

1. Researcher A: primary or official sources.
2. Researcher B: implementation evidence, statistics, or comparative cases.
3. Gunshi: reconcile conflicts, test claims, and identify uncertainty.

### Large document or dataset

Partition by non-overlapping sections or records. Give every agent the same extraction schema, then have the lead normalize terminology and check for omissions.

### Incident or failing tests

1. Reproducer: establish the failure and minimal evidence.
2. Investigator: trace the likely cause without editing overlapping files.
3. Gunshi: challenge the causal claim and assess regression risk.

## Prompt checklist for each subagent

- Objective and deliverable
- Explicit scope and exclusions
- Relevant files, URLs, or data
- Whether edits are allowed and exclusive ownership boundaries
- Required tests or evidence
- Desired summary format

## Integration checklist

- Resolve contradictory findings.
- Confirm every acceptance criterion.
- Re-run tests after integration when writes occurred.
- Report skipped or unavailable verification explicitly.
- Preserve a concise audit trail of sources, paths, and commands.
