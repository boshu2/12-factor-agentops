# Factor I: Context Is Everything

## Rule: Manage what enters the context window like you manage what enters production.

Every token you load into an agent's context window is a decision. Every file read, every search result, every log line, every instruction appended to the prompt. These decisions compound. Get them wrong and your agent drowns. Get them right and it executes with precision.

Context management is the foundational discipline of operational agent work. It separates agents that ship reliable work from agents that confabulate, repeat themselves, and ignore half of what you tell them.

---

## Rationale

### The Problem: Context Windows Are Not Infinite Memory

LLMs have large context windows now—200K tokens, 500K tokens, millions of tokens on the horizon. This creates a dangerous illusion: that you can dump everything into context and let the model sort it out.

You cannot.

Research on the "lost in the middle" effect (Liu et al., 2023) demonstrates that LLMs attend strongly to the beginning and end of their context window but lose track of information in the middle. Place a critical fact in the middle of a 100K-token context and the model may ignore it entirely, even when that fact is the key to answering the question you just asked.

This isn't a bug. It's how attention mechanisms work. The model has finite computational resources to distribute across the entire context. Early tokens and recent tokens get the most attention. The middle gets less. The longer the context, the more severe this effect becomes.

### Observable Symptoms of Context Overload

You know you have a context management problem when you see:

1. **The agent repeats itself.** It tells you the same thing multiple times because it can't track what it already said 50K tokens ago.

2. **The agent ignores recent instructions.** You tell it to stop doing X, and two responses later it's doing X again. The instruction got lost in the noise.

3. **The agent confabulates details.** It invents facts that sound plausible but aren't in the codebase. It's pattern-matching on noise instead of retrieving accurate information.

4. **The agent contradicts its own earlier output.** It proposes a solution, then forgets it proposed that solution and suggests something incompatible five messages later.

5. **The agent asks for information it already has.** You gave it the schema three prompts ago. Now it's asking for the schema again because it can't find it in the 80K tokens of accumulated transcript.

These are not model failures. These are context management failures.

### Cognitive Load Theory Applied to AI

Cognitive load theory (Sweller, 1988) describes how human working memory is limited and how learning is impaired when working memory is overloaded. The principle applies to LLMs as well.

An LLM's "working memory" is its context window. The model can only effectively process a subset of what's in that window at any given time. Load it with 200K tokens of irrelevant code, debug logs, and conversation history, and you impose massive extraneous cognitive load. The model spends its attention budget sifting through noise instead of reasoning about the problem.

The agent that knows less but knows the RIGHT things outperforms the one drowning in context.

### The Context Budget Is Finite

Even with a 200K token context window, you have a finite budget. Here's how it gets spent:

- **System prompt and instructions:** 2K-5K tokens
- **Tool definitions:** 5K-15K tokens (if you have many tools)
- **Conversation history:** Grows unbounded if not managed
- **Retrieved context (code, docs, search results):** Can easily hit 50K-100K tokens
- **Agent's own output:** Accumulates with every response

If you're not actively managing this budget, you'll hit the limit or create a context so diluted that the model can't focus on what matters.

### Just-In-Time Loading

The solution is just-in-time context loading. Don't load everything the agent might need. Load what it needs NOW, for THIS step.

Example: You're working on a multi-phase refactoring task.

- **Phase 1 (Analysis):** Load the target module, its direct dependencies, and test files. Don't load the entire codebase. Don't load the git history. Don't load unrelated modules.

- **Phase 2 (Design):** Load the analysis summary from Phase 1. Don't reload the full codebase. The agent doesn't need to re-analyze—it needs to design based on the summary.

- **Phase 3 (Implementation):** Load the design document and the specific files being edited. Don't reload the analysis. Don't reload unrelated files.

- **Phase 4 (Validation):** Load the implementation summary, the test suite, and the validation checklist. Don't reload the design. Don't reload the codebase.

Each phase gets exactly what it needs, when it needs it. Nothing more.

### Compression Between Phases

When you hand off work from one phase to the next—or from one session to the next—don't pass the entire transcript.

Write a summary.

A good handoff summary is 3-20 lines:
- What was the goal?
- What did you do?
- What decisions did you make?
- What's the next step?

This is compression. You're distilling 10K tokens of conversation into 200 tokens of essential information. The next agent (or the next session of the same agent) loads the summary, not the full transcript.

This is how you prevent context bloat. This is how you keep agents focused.

### Real-World Example: The 80K Token Debugging Session

You're debugging a production issue. The agent:
1. Loads the error logs (5K tokens)
2. Loads the module where the error occurred (8K tokens)
3. Loads the test suite (10K tokens)
4. Loads the git history for that module (15K tokens)
5. Loads three related modules "just in case" (20K tokens)
6. Loads the entire conversation history (22K tokens)

Total: 80K tokens.

The agent spends five responses wandering through irrelevant code paths because it can't distinguish signal from noise. It suggests changes that don't match the error. It forgets what you already ruled out.

Now try this:
1. Load the error log (5K tokens)
2. Load the failing function and its direct callees (3K tokens)
3. Load the relevant test (1K tokens)

Total: 9K tokens.

The agent identifies the bug in one response. It proposes a fix. It works.

The difference is focus. The smaller context contained exactly what was needed. The larger context was 90% noise.

---

## What Good Looks Like

### 1. Explicit Context Budgets

You know what you're loading and why. Before you start a task, you decide:
- What files does this task require?
- What conversation history is essential?
- What can be summarized or discarded?

You treat context like memory allocation. You allocate what you need. You free what you don't.

### 2. Phase-Based Context Windows

You structure work into phases, and each phase has its own clean context window:
- **Research phase:** Load the codebase slices needed for exploration. At the end, write a research summary.
- **Planning phase:** Load the research summary (not the full transcript). Write a plan document.
- **Implementation phase:** Load the plan (not the research). Load the files being edited. Write an implementation summary.
- **Validation phase:** Load the implementation summary and tests. Write a validation report.

Each phase starts fresh with only the essential handoff from the previous phase.

### 3. Aggressive Summarization

You summarize constantly:
- After every subtask, write a 3-line summary.
- After every session, write a handoff note.
- After every phase, compress the findings into a structured document.

You never pass a 50K token transcript to the next step when you can pass a 500-token summary.

### 4. Search Before Load

Before loading an entire file, you search. You use `grep` to find the relevant function. You use `git log -S` to find the commit that introduced a change. You use AST tools to extract just the class definition.

You load the minimum viable slice of context to answer the current question.

### 5. Ephemeral Contexts for Throwaway Work

For one-off tasks (answering a quick question, generating a snippet, checking a fact), you spawn a fresh session with a minimal context. You don't pollute your main session's context with throwaway work.

This is the agent equivalent of using a scratch buffer.

### 6. Monitoring Context Utilization

You track how much context you're using:
- How many tokens in the current window?
- How much is conversation history vs. retrieved content?
- Is the model still attending to early instructions, or are they lost in the middle?

You adjust based on observed behavior. If the agent starts repeating itself or ignoring instructions, you know you've exceeded the effective context limit.

---

## Without Tooling

You don't need sophisticated context management frameworks to apply this factor. You can do it manually with basic discipline:

### 1. Keep Sessions Short

Don't run a single agent session for six hours. After 30-60 minutes, or after completing a discrete subtask, wrap up. Write a 3-line summary. Start a fresh session for the next task.

This prevents unbounded transcript growth.

### 2. Start Fresh for New Tasks

When you switch from Task A to Task B, start a new session. Don't carry forward the entire context from Task A. If Task B needs information from Task A, write a handoff summary and paste it into the new session.

This keeps context focused on one problem at a time.

### 3. Manually Write Handoff Summaries

When you finish a phase or a session, write:
```
HANDOFF:
- Goal: [what you were trying to do]
- Done: [what you accomplished]
- Decisions: [key choices made]
- Next: [what comes next]
```

This takes 60 seconds. It saves you from re-reading 10K tokens of transcript in the next session.

### 4. Load Files Selectively

Don't tell the agent "read the entire src/ directory." Tell it "read src/auth.py and src/models/user.py."

You manually identify the relevant files before invoking the agent. This is research time well spent.

### 5. Use Scratch Sessions for Questions

If you need to answer a one-off question (e.g., "what's the signature of this API?"), open a scratch session, ask the question, get the answer, close the session.

Don't pollute your main session's context with every stray question.

### 6. Regularly Audit Your Context

Every 10-15 minutes, ask yourself:
- Is the agent still using the information I loaded earlier?
- Have I loaded things I haven't referenced in the last three exchanges?
- Is the conversation wandering?

If yes to any of these, prune the context or start fresh.

---

## Why This Factor Comes First

Context management is Factor I because it's the foundation. If you get this wrong, nothing else works.

- **You can't plan effectively** if the agent is drowning in irrelevant context.
- **You can't implement reliably** if the agent forgets its own decisions mid-task.
- **You can't validate thoroughly** if the agent can't attend to the checklist you gave it.
- **You can't iterate quickly** if every session requires re-loading the entire world.

Every other factor in this framework depends on the agent having a clean, focused context window.

Master context management, and you unlock the agent's ability to reason clearly, execute precisely, and operate autonomously. Ignore it, and you'll spend your time fighting confabulation, repetition, and drift.

Context is everything. Manage it like production.

---

## Key Takeaways

1. **Large context windows are not infinite memory.** LLMs suffer from the "lost in the middle" effect. More context is not always better.

2. **Observable symptoms of context overload:** repetition, ignored instructions, confabulation, contradictions, asking for already-provided information.

3. **Just-in-time loading:** Load what you need for THIS step, not everything you might need for ALL steps.

4. **Compression between phases:** Summarize before handoff. Don't pass full transcripts.

5. **The agent that knows less but knows the RIGHT things wins.** Focus beats volume.

6. **Without tooling:** Keep sessions short, start fresh for new tasks, write handoff summaries, load files selectively, use scratch sessions for one-off questions.

Context management is not a nice-to-have optimization. It's the foundational discipline that determines whether your agent operates or flails.

Treat your context budget like production resources. Allocate deliberately. Monitor actively. Prune aggressively.

---

## References

- Liu, N. F., Lin, K., Hewitt, J., Paranjape, A., Bevilacqua, M., Petroni, F., & Liang, P. (2023). Lost in the Middle: How Language Models Use Long Contexts. *arXiv preprint arXiv:2307.03172*.

- Sweller, J. (1988). Cognitive load during problem solving: Effects on learning. *Cognitive Science, 12*(2), 257-285.

---

**Next:** [Factor II: One Agent, One Job](./02-one-agent-one-job.md)
