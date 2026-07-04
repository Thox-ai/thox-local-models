# THOX Local Models

<!-- thox-badges -->
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square&labelColor=09090b)](LICENSE)
[![THOX.ai](https://img.shields.io/badge/THOX.ai-portfolio-0a0?style=flat-square&labelColor=09090b)](https://thox.ai)
[![Status](https://img.shields.io/badge/status-success-green?style=flat-square&labelColor=09090b)](./scripts/validate-models.sh)
[![Latest Release](https://img.shields.io/github/v/release/Thox-ai/thox-local-models?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/thox-local-models/releases)
[![Last Commit](https://img.shields.io/github/last-commit/Thox-ai/thox-local-models?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/thox-local-models)
[![Open Issues](https://img.shields.io/github/issues/Thox-ai/thox-local-models?style=flat-square&labelColor=09090b)](https://github.com/Thox-ai/thox-local-models/issues)
<!-- /thox-badges -->

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
