# Device Recommendations

## ThoxKey USB

**Default model:** THOX Local Vision E2B

**Source:** https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive

**Recommended quant:** Q4_K_P

**Notes:**

- Include mmproj only when storage allows.
- Use 32768 context by default.
- Provide Q3_K_P fallback for weak host machines.
- Keep THOX Local Code 9B optional because it is larger and better suited to workstation-class hardware.

## ThoxMini

**Default model:** THOX Local Vision E2B

**Recommended quant:** Q3_K_P or IQ3_M

**Context:** 8192 to 16384 depending on memory.

## ThoxMini Air

**Default model:** THOX Local Vision E2B lightweight fallback

**Recommended quant:** Q2_K_P, Q3_K_P, or external host-assisted mode

**Context:** Keep context small.

## ThoxNova

**Default models:** THOX Local Vision E2B and THOX Local Code 9B

**Sources:**

- https://huggingface.co/HauhauCS/Gemma-4-E2B-Uncensored-HauhauCS-Aggressive
- https://huggingface.co/llmfan46/Qwythos-9B-Claude-Mythos-5-1M-uncensored-heretic-GGUF

**Use:**

- THOX Local Vision E2B for multimodal assistance.
- THOX Local Code 9B for coding and long-context work.

## Windows workstation

**Recommended model:** THOX Local Code 9B

**Optional secondary model:** THOX Local Vision E2B

**High-memory context:** Allowed when RAM and runtime support it.

## macOS workstation

**Recommended model:** THOX Local Vision E2B for general local work.

**Use THOX Local Code 9B** when memory allows.
