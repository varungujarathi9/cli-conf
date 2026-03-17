# Global Claude Code Instructions

## Workflow Orchestration

### 1. Plan Mode Default
- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately — don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

### 2. Subagent Strategy
- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution

### 3. Self-Improvement Loop
- After ANY correction from the user: update `tasks/lessons.md` with the pattern
- Write rules for yourself that prevent the same mistake
- Ruthlessly iterate on these lessons until mistake rate drops
- Review lessons at session start for relevant project

### 4. Verification Before Done
- Never mark a task complete without proving it works
- Diff behavior between main and your changes when relevant
- Ask yourself: "Would a staff engineer approve this?"
- Run tests, check logs, demonstrate correctness

### 5. Demand Elegance (Balanced)
- For non-trivial changes: pause and ask "is there a more elegant way?"
- If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- Skip this for simple, obvious fixes — don't over-engineer
- Challenge your own work before presenting it

### 6. Autonomous Bug Fixing
- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests — then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

### 7. Dynamic Timeout Management
- When waiting for tasks (agents, builds, tests), set timeouts dynamically based on predicted execution time
- Calculate expected duration from task complexity and historical patterns
- Keep timeouts **lower than defaults** to catch stalls early and fail fast
- Don't use maximum timeout values for routine operations — reserve those for known slow tasks only
- If a task exceeds predicted timeout, investigate immediately instead of extending the wait

---

## Task Management

1. **Plan First:** Write plan to `tasks/todo.md` with checkable items
2. **Verify Plan:** Check in before starting implementation
3. **Track Progress:** Mark items complete as you go
4. **Explain Changes:** High-level summary at each step
5. **Document Results:** Add review section to `tasks/todo.md`
6. **Capture Lessons:** Update `tasks/lessons.md` after corrections

---

## Core Principles

- **Simplicity First:** Make every change as simple as possible. Impact minimal code.
- **No Laziness:** Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact:** Changes should only touch what's necessary. Avoid introducing bugs.

## Keeping CLAUDE.md Up to Date

**Important:** This file should be updated frequently as the project evolves. Whenever significant context is learned — job timings, data size characteristics, debugging insights, new patterns, config changes — it should be recorded here so future sessions start with accurate context.



## Working Style

**Ask questions liberally.** This codebase involves complex infrastructure, data pipelines, and ML systems where wrong assumptions are costly (long Dataproc jobs, GCP costs, data correctness). Before acting on ambiguous tasks:
- Ask as many clarifying questions as needed — more questions is always better than a wrong assumption
- Confirm input/output paths, modes (training vs inference), environment (prod vs staging), and data characteristics before submitting jobs
- When debugging, ask about observed symptoms before proposing fixes
- When tuning parameters, ask about cluster specs, data sizes, and past failures first

**Fix bugs carefully.** A bad fix is worse than no fix — a failed Dataproc job wastes hours.
- Before applying a fix, think through second-order effects: does this change break other code paths, other modes (training vs inference), or downstream jobs?
- Validate the solution before running a full job — use `sample_fraction: 0.01` in the config to run a quick end-to-end test on 1% of data first
- If the fix is non-trivial, explain the reasoning and ask for confirmation before submitting

