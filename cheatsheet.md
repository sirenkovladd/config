# Git Commands Cheatsheet

## Understanding a Codebase Before Reading Code

Five git commands to diagnose a new codebase before opening any files.

---

### Most Changed Files (Churn Hotspots)

```bash
git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20
```

Run from `app/` or `src/` directory to avoid noise from lockfiles, changelogs, and generated code. Shows the 20 most-changed files in the last year. High churn on a file that nobody owns indicates "codebase drag" – unpredictable blast radius, resistance to change, padded estimates. High churn doesn't automatically mean bad (could be active development), but combined with bug clusters it signals highest risk.

### Contributors (Bus Factor)

```bash
git shortlog -sn --no-merges
```

All contributors ranked by commit count. One person with 60%+ commits = bus factor risk. Left recently = crisis. Mix of many old contributors but few recent ones means original builders ≠ current maintainers.

```bash
git shortlog -sn --no-merges --since="6 months ago"
```

Recent contributors only. Compare against overall list to identify key people who are no longer active.

Caveat: squash-merge workflows compress authorship and reflect who merged, not who wrote the code.

### Bug Clusters

```bash
git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20
```

Cross-reference commit messages for bug-related keywords. Files that appear on both churn + bug lists are the highest-risk code: they keep breaking and keep getting patched but never properly fixed. Effectiveness depends on commit message discipline.

### Project Velocity

```bash
git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
```

Commit count by month across entire repo history. Steady rhythm = healthy. Sharp drop (>50%) often indicates someone left. Declining curve over 6–12 months = loss of momentum. Periodic spikes with quiet months = batch releases rather than continuous shipping. This is team data, not code data.

### Firefighting Frequency

```bash
git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'
```

Count revert/hotfix occurrences. A handful per year is normal. Reverts every couple weeks means the team doesn't trust its deploy process – deeper issues like unreliable tests, missing staging, or a hard-to-rollback pipeline. Zero could mean stable OR nobody writes descriptive commit messages.

---

Source: [The Git Commands I Run Before Reading Any Code](https://piechowski.io/post/git-commands-before-reading-code/) by Ally Piechowski.
