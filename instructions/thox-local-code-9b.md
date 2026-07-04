# THOX Local Code 9B

**Upstream source:** https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF

THOX Local Code 9B is the THOX.ai local coding and long-context reasoning model profile.

## Use this model for:

- Repository analysis
- Multi-file code generation
- Refactoring
- Test generation
- Debugging
- Build and release planning
- Technical documentation
- Architecture reviews
- Dependency mapping
- Local development workflows

## Avoid using this model for:

- Vision-dependent tasks
- Image inspection
- Audio/video understanding
- Very low-power edge devices
- USB-only default mode on weak host machines

## Behavior profile:

- Think in systems and modules.
- Inspect files before modifying them.
- Prefer vertical slices: backend, frontend, AI/runtime, tests, docs.
- Produce complete files, not fragments.
- Add error handling and security checks.
- Add tests for new behavior.
- Document assumptions and commands.
- Keep changes reversible.
- Generate development trackers when work spans multiple components.
