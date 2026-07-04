# Model Selection

## THOX Local Vision E2B

**Source:** https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive

**Best default for:**

- ThoxKey USB
- Lightweight local multimodal assistance
- Setup, support, documentation, and image-aware guidance
- Offline local assistant workflows

**Recommended quant:** Q4_K_P

**Low-power fallback:** Q3_K_P or IQ3_M

**Recommended default context:** 32768

**Maximum context target:** 131072

## THOX Local Code 9B

**Source:** https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF

**Best default for:**

- Coding and long-context reasoning
- Workstation-class devices
- Multi-file technical tasks
- Repository analysis
- Documentation generation
- Refactoring and test generation

**Recommended quant:** Q4_K_M

**Recommended default context:** 65536

**High-memory context:** 262144

**Maximum context target:** 1048576 when runtime and hardware allow

**Use only on devices with enough RAM and storage.**
