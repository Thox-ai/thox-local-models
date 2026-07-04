#!/usr/bin/env python3
"""THOX Local Models Validation Script
Exit code 0 if all checks pass, 1 if any required files are missing or JSON is invalid.
"""

import json
import sys
from pathlib import Path

REPO_ROOT = Path("/Volumes/VibeStore/thox-local-models")
# Use os.path.join for cross-platform compatibility
VARIANT = "thox-local-vision-e2b"
VARIANT_DISPLAY = "THOX Local Vision E2B"
VARIANT_ROLE = "local_multimodal_edge_assistant"
VARIANT_URL = "https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive"
VARIANT_FILE = "Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf"
VARIANT_MMPROJ = "mmproj-Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-f16.gguf"
VARIANT_CHAT_TEMPLATE = "jinja"

VARIANT2 = "thox-local-code-9b"
VARIANT2_DISPLAY = "THOX Local Code 9B"
VARIANT2_ROLE = "local_coding_reasoning_agent_model"
VARIANT2_URL = "https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF"
VARIANT2_FILE = "Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF-Q4_K_M.gguf"

REQUIRED_FIELDS = ["id", "display_name", "family", "role", "upstream", "capabilities", "runtime", "generation", "thox"]

import os


def read_json_file(path: Path) -> dict | None:
    try:
        print(f"DEBUG: reading {path}")
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError as e:
        print(f"FAIL: {path} not found")
        return None
    except json.JSONDecodeError as e:
        print(f"FAIL: {path} JSON parse error: {e}")
        return None
    except Exception as e:
        print(f"FAIL: {path} unexpected error: {type(e).__name__}: {e}")
        return None


def check_file(name: str, path: Path) -> bool:
    if not path.is_file():
        print(f"FAIL: {name} missing: {path}")
        return False
    print(f"OK: {name}")
    return True


def check_manifest(name: str, data: dict) -> bool:
    for field in REQUIRED_FIELDS:
        if field not in data:
            print(f"FAIL: {name} missing required field: {field}")
            return False
    print(f"OK: {name} manifest has all required fields")
    return True


def check_upstream(name: str, upstream: dict) -> bool:
    for field in ["repo", "url"]:
        if field not in upstream:
            print(f"FAIL: {name} missing upstream.{field}")
            return False
    print(f"OK: {name} upstream fields present")
    return True


def main():
    print("=== Checking models/ directory ===")
    models_dir = REPO_ROOT / "models"
    if not models_dir.is_dir():
        print("FAIL: models/ directory is missing")
        sys.exit(1)
    print("OK: models/ directory exists")

    print("=== Checking Gemma E2B GGUF file ===")
    gemma_gguf = models_dir / VARIANT_FILE
    if not check_file(VARIANT_FILE, gemma_gguf):
        sys.exit(1)

    print("=== Checking Gemma E2B mmproj file ===")
    mmproj = models_dir / VARIANT_MMPROJ
    if not check_file(VARIANT_MMPROJ, mmproj):
        sys.exit(1)

    print("=== Checking Qwythos 9B GGUF file ===")
    qwythos_gguf = models_dir / VARIANT2_FILE
    if not check_file(VARIANT2_FILE, qwythos_gguf):
        sys.exit(1)

    print("=== Validating manifest JSON files ===")
    vision_path = os.path.join(REPO_ROOT, "manifests", VARIANT + ".json")
    if not os.path.exists(vision_path):
        print(f"FAIL: {vision_path} not found")
        sys.exit(1)
    vision_manifest = read_json_file(Path(vision_path))
    if vision_manifest is None:
        sys.exit(1)
    code_path = os.path.join(REPO_ROOT, "manifests", VARIANT2 + ".json")
    if not os.path.exists(code_path):
        print(f"FAIL: {code_path} not found")
        sys.exit(1)
    code_manifest = read_json_file(Path(code_path))
    if code_manifest is None:
        sys.exit(1)
    print("OK: All manifests loaded successfully")

    print("=== Checking required JSON fields ===")
    if not check_manifest(VARIANT, vision_manifest) or not check_manifest(VARIANT2, code_manifest):
        sys.exit(1)

    print("=== Checking upstream fields (repo and url) ===")
    vision_upstream = vision_manifest["upstream"]
    code_upstream = code_manifest["upstream"]
    if not check_upstream(VARIANT, vision_upstream) or not check_upstream(VARIANT2, code_upstream):
        sys.exit(1)

    print("=== Validating upstream URLs ===")
    if vision_upstream["url"] != VARIANT_URL:
        print(f"FAIL: {VARIANT} wrong upstream.url: {vision_upstream['url']}")
        sys.exit(1)
    if code_upstream["url"] != VARIANT2_URL:
        print(f"FAIL: {VARIANT2} wrong upstream.url: {code_upstream['url']}")
        sys.exit(1)
    print("OK: All upstream URLs verified")

    print("")
    print("=== Validation Summary ===")
    print("Models directory:      OK")
    print("Gemma GGUF file:       OK")
    print("Gemma mmproj file:     OK")
    print("Qwythos GGUF file:     OK")
    print(f"{VARIANT} manifest JSON:  OK")
    print(f"{VARIANT2} manifest JSON: OK")
    print("All upstream URLs:     OK")
    print("All required fields:   OK")
    print("")
    print("All checks passed!")
    sys.exit(0)


if __name__ == "__main__":
    main()
