# Portfolio Awards and Section Order Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Place Selected Publications & Presentations before Experience and add a compact four-item Awards section between them.

**Architecture:** Keep the existing Jekyll data-driven structure. Add award records to `_data/data.yml`, render them through a focused `_includes/awards.html` partial, and control section order in `index.html`.

**Tech Stack:** Jekyll, Liquid templates, YAML, shell content checks, Docker-based Jekyll build.

**Spec:** `docs/superpowers/specs/2026-11-16-portfolio-awards-order-design.md`

## Global Constraints

- Page order: About, Selected Publications & Presentations, Awards, Experience.
- Awards remain one line each with no descriptions.
- Preserve the existing visual style and mobile layout.
- Do not display Swati's last name or add unverified award details, amounts, or links.

## Review Focus

- Section order: the source and rendered page must put Publications before Awards before Experience.
- Missing award data: the Awards section must not render when `awards` is absent.
- Privacy: the rendered page must contain no last name.
- Mobile scanability: award names and dates must remain readable without clipping.
- Content accuracy: all four award names and periods must match the approved spec exactly.

---

### Task 1: Reorder Sections and Add Awards

**Files:**
- Create: `_includes/awards.html`
- Modify: `_data/data.yml`
- Modify: `index.html`
- Modify: `scripts/check_stage1.sh`

**Interfaces:**
- Consumes: `site.data.data.awards` with `title` and `list` entries containing `name` and `time`.
- Produces: an optional `awards-section` rendered between publications and experience.

- [ ] **Step 1: Add failing source checks**

Add assertions to `scripts/check_stage1.sh` for the four exact awards, the Awards title, and source order `publications.html` before `awards.html` before `experiences.html`.

- [ ] **Step 2: Run the checks and verify RED**

Run: `sh scripts/check_stage1.sh`

Expected: FAIL because `_data/data.yml` has no `awards` block and `index.html` has no awards include.

- [ ] **Step 3: Add the awards data**

Add four reverse-chronological records to `_data/data.yml`: UBC Graduate Tuition Award (2021-2024), GHC Scholar (2023), Generation Google Scholar (2022), and Mitacs Graduate Fellow (2021).

- [ ] **Step 4: Add the Awards partial**

Create `_includes/awards.html` using the existing section heading, item, upper-row, title, and time classes; use a trophy icon and guard the section with `{% if awards %}`.

- [ ] **Step 5: Reorder the page includes**

Update `index.html` so publications renders first, awards second, and experiences third after About/Education.

- [ ] **Step 6: Run source checks and verify GREEN**

Run: `sh scripts/check_stage1.sh`

Expected: `Stage 1 content checks passed.`

- [ ] **Step 7: Build and inspect the rendered page**

Run: `docker compose exec -T jekyll jekyll build --destination /tmp/portfolio-awards-build`

Expected: exit 0. Then inspect `http://127.0.0.1:4000/` and confirm the approved order, four awards, mobile readability, and no last name.

- [ ] **Step 8: Commit**

```bash
git add _data/data.yml _includes/awards.html index.html scripts/check_stage1.sh
git commit -m "content: add awards and reorder sections"
```
