import unittest

from pr_contract_check import check

GOOD_BODY = """# Summary

## Validation Evidence

- tests passed

## Review of Record

- Status: PASS

## Human Gate

- Required: no
- Reason: low risk

## Operator Summary

- ready

## Review Recommendation

- none
"""

RAW_BODY = """# Summary

## Validation Evidence

- 

## Review of Record

- Status: pending
- Reviewer:
- Link:

## Human Gate

- Required: yes/no
- Reason:

## Operator Summary

## Review Recommendation
"""


class PrContractCheckTests(unittest.TestCase):
    def test_valid_body_and_labels_pass(self):
        self.assertEqual(check(GOOD_BODY, ["review:pass"]), [])

    def test_missing_sections_fail(self):
        failures = check("# Summary", [])
        self.assertTrue(any("Validation Evidence" in item for item in failures))

    def test_raw_template_fails(self):
        failures = check(RAW_BODY, [])
        self.assertTrue(any("empty section" in item for item in failures))
        self.assertTrue(any("Human Gate" in item for item in failures))

    def test_auto_merge_requires_review_pass(self):
        failures = check(GOOD_BODY, ["auto-merge:ok"])
        self.assertIn("auto-merge:ok requires review:pass", failures)

    def test_auto_merge_conflicts_with_stop_labels(self):
        for label in ["needs-human", "needs-fix", "blocked"]:
            with self.subTest(label=label):
                failures = check(GOOD_BODY, ["auto-merge:ok", "review:pass", label])
                self.assertTrue(any(label in item for item in failures))

    def test_auto_merge_conflicts_with_protected_risk(self):
        for label in ["risk:protected", "risk:release"]:
            with self.subTest(label=label):
                failures = check(GOOD_BODY, ["auto-merge:ok", "review:pass", label])
                self.assertTrue(any(label in item for item in failures))

    def test_review_pass_conflicts_with_needs_fix(self):
        failures = check(GOOD_BODY, ["review:pass", "needs-fix"])
        self.assertIn("review:pass conflicts with needs-fix", failures)

    def test_auto_merge_conflicts_with_required_human_gate(self):
        body = GOOD_BODY.replace("Required: no", "Required: yes")
        failures = check(body, ["auto-merge:ok", "review:pass"])
        self.assertTrue(any("Human Gate" in item for item in failures))

    def test_unknown_labels_are_ignored(self):
        self.assertEqual(check(GOOD_BODY, ["review:pass", "custom:label"]), [])


if __name__ == "__main__":
    unittest.main()
