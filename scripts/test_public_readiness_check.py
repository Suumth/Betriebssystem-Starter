import re
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "public-readiness-check.sh"


def legacy_label_pattern(label):
    script = SCRIPT.read_text(encoding="utf-8")
    prefix_match = re.search(
        r'^legacy_label_pattern_prefix=\'([^\']+)\'',
        script,
        re.M,
    )
    suffix_match = re.search(
        r'^legacy_label_pattern_suffix=\'([^\']+)\'',
        script,
        re.M,
    )
    if prefix_match is None or suffix_match is None:
        raise AssertionError("legacy label boundary pattern is not declared")
    return f"{prefix_match.group(1)}{label}{suffix_match.group(1)}"


def legacy_label_scan(label, text):
    with tempfile.TemporaryDirectory() as tmpdir:
        target = Path(tmpdir) / "sample.md"
        target.write_text(text, encoding="utf-8")
        result = subprocess.run(
            ["grep", "-RInE", label, str(target)],
            check=False,
            capture_output=True,
            text=True,
        )
        return result.returncode == 0


class PublicReadinessCheckTests(unittest.TestCase):
    def test_legacy_label_scan_ignores_human_gated_prose(self):
        self.assertFalse(
            legacy_label_scan(
                legacy_label_pattern("human-gate"),
                "Rule changes stay human-gated and require an operator decision.",
            )
        )

    def test_legacy_label_scan_still_finds_exact_legacy_label(self):
        self.assertTrue(
            legacy_label_scan(
                legacy_label_pattern("human-gate"),
                "Do not use the old human-gate label.",
            )
        )


if __name__ == "__main__":
    unittest.main()
