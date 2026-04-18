# Human Gate Checklist

Use this checklist after AL handoff (`AL done`) and before external close.

## Gate 1 - Testing

- [ ] Required test command ran successfully.
- [ ] AC -> test mapping in task file is complete.
- [ ] No skipped critical tests without explicit reason.

## Gate 2 - Code Review

- [ ] Change is within task scope.
- [ ] Error handling and edge cases are covered.
- [ ] No accidental architecture drift.

## Gate 3 - Merge Request

- [ ] PR includes task file reference.
- [ ] PR includes clear how-to-test steps.
- [ ] Breaking or operational impacts are called out.

## Gate 4 - Close

- [ ] External process marks task as Done.
- [ ] Progress log updated with final decisions.
- [ ] Follow-up tickets created for deferred items.
