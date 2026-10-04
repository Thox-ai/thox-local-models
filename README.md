# THOX Local Models

[![License](https://img.shields.io/badge/license-MIT-171719)](LICENSE)
![Visibility](https://img.shields.io/badge/visibility-public-171719)
[![Release](https://img.shields.io/badge/release-v1.0.0-171719)](https://github.com/Thox-ai/thox-local-models/releases/tag/v1.0.0)

**THOX.ai LLC. Your AI. Your Data. Your Rules.**

## Description

THOX Local Models - local-first GGUF model profiles, presets, instructions, and device recommendations for THOX.ai runtimes. It is packaging metadata for those profiles. It does not commit model weights, and it is not the thox.ai website.

The GitHub About text is that first sentence. This sweep did not run the validation scripts and does not badge them as passing.

## Releases

**Latest published GitHub Release:** [v1.0.0](https://github.com/Thox-ai/thox-local-models/releases/tag/v1.0.0) (2026-07-04, 3:16 PM CT, not a prerelease).

Release name: `THOX Local Models v1.0.0`. `GET /repos/Thox-ai/thox-local-models/releases/latest` returned that tag on 2026-10-03. No other published release was in the list. This README does not create a release.

## Agent handoffs

**No handoff file in this repo yet.**

`HANDOFF.md`, `handoffs/`, and `AGENTS.md` are not at the repo root. A search of [`ttracx/thox-handoffs`](https://github.com/ttracx/thox-handoffs) on 2026-10-03 did not find a named lane file for this repo. This README does not create one.

## Instructions

There is no `AGENTS.md` or `HANDOFF.md`. Read [CONTRIBUTING.md](CONTRIBUTING.md), then the validation section below.

Commands already in this README:

```bash
./scripts/validate-models.sh
node scripts/generate-model-index.js
```

The script comment says exit code 0 means the file checks passed. This README edit did not run that script and does not claim a new pass. Do not commit model weights.

This README edit does not create a release and does not publish thox.ai.

## Purpose

This package defines THOX.ai local model profiles, presets, instructions, attribution, and device recommendations for local-first THOX.ai runtimes.

## Models

| THOX Alias | Display Name | Upstream Repo | Source URL | Best Use |
|------------|--------------|----------------|-------------|----------|
| thox-local-vision-e2b | THOX Local Vision E2B | HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive | https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive | USB, edge, multimodal, local assistant |
| thox-local-code-9b | THOX Local Code 9B | llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF | https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF | coding, long-context reasoning, workstation use |

## Folder Layout

```
thox-local-models/
├── README.md
├── .gitignore
├── models/              # Place model GGUF files here
│   └── .gitkeep
├── manifests/           # Model manifest JSON files
│   ├── thox-local-vision-e2b.json
│   └── thox-local-code-9b.json
├── presets/             # Generation preset JSON files
│   ├── thox-local-vision-e2b.json
│   └── thox-local-code-9b.json
├── instructions/        # Model usage and behavior instructions
│   ├── thox-local-system-prompt.md
│   ├── thox-local-vision-e2b.md
│   └── thox-local-code-9b.md
├── scripts/             # Validation and index generation
│   ├── validate-models.ps1
│   ├── validate-models.sh
│   └── generate-model-index.js
├── index/
│   └── models.json      # Auto-generated model index
└── docs/
    ├── model-attribution.md
    ├── model-selection.md
    └── device-recommendations.md
```

## How to Place Model Files

Copy your model GGUF files into the `models/` directory:

```bash
# Example for THOX Local Vision E2B
cp Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-Q4_K_P.gguf models/
cp mmproj-Gemma-4-E2B-Uncensored-HauhauCS-Aggressive-f16.gguf models/

# Example for THOX Local Code 9B
cp Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF-Q4_K_M.gguf models/
```

## How to Run Validation Scripts

Validate that all required files are present and JSON manifests are correct:

```bash
# macOS/Linux
./scripts/validate-models.sh

# Windows PowerShell
./scripts/validate-models.ps1
```

Exit code 0 means all checks passed. Exit code 1 means required files are missing or JSON is invalid.

## How to Regenerate Index

Rebuild the auto-generated model index:

```bash
node scripts/generate-model-index.js
```

## Attribution Notice

THOX Local models are THOX.ai packaging profiles. They do not claim ownership of upstream model weights. All upstream licenses, model cards, repository names, and source URLs are preserved. This package only provides THOX.ai aliases, presets, instructions, and device recommendations.

## Security Note

All model files run locally after download. No model weights are committed to Git — only metadata, manifests, and instructions. Large binary model files should never be committed.

## Notes

- This package does not include WebUI setup.
- This package does not include Hermes setup.
- This package only defines local model packaging and THOX model metadata.

## Legal

Copyright (c) 2026 Thox.ai LLC. All rights reserved.

Thox.ai LLC is an independent Texas limited liability company.

- **Tommy Xaypanya** - Chief Technology Officer (CTO)
- **Craig Ross** - Chief Executive Officer (CEO)

Licensed under the [MIT License](LICENSE).