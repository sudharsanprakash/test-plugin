---
name: building
description: |
  Generates a house-build timeline spreadsheet (phases, tasks, start/end dates, duration) for planning a home construction or major renovation project.
  Make sure to use this skill whenever the user mentions building a house, construction, house plan, renovation, contractors, or permits, even if they don't explicitly ask for a "spreadsheet" or "timeline."
---

# Construction Timeline Planner

Generates a spreadsheet-based construction timeline for building a house.

## When triggered

Ask the user (briefly, one or two questions) if not already known:
- Roughly how big / what type of house (helps scale the phase list — e.g. single-story vs multi-story)
- A rough target start date (if none given, use today's date as the anchor and note that dates are placeholders)

Don't over-interview — if the user just wants a generic sample timeline, proceed with reasonable defaults and say so.

## Output

Use the xlsx skill to produce an Excel file with one sheet named "Timeline" containing these columns:

| Phase | Task | Start Date | End Date | Duration (days) | Status |

Populate with the standard house-build phase sequence, each broken into a few representative tasks:

1. **Pre-Construction** — permits & approvals, site survey, architectural finalization
2. **Site Preparation** — clearing, excavation, grading
3. **Foundation** — footings, foundation pour, curing
4. **Framing** — wall framing, roof framing, sheathing
5. **Roofing** — roofing installation, waterproofing
6. **Exterior** — windows & doors, siding/exterior finish
7. **Rough-In** — electrical rough-in, plumbing rough-in, HVAC rough-in
8. **Insulation & Drywall** — insulation, drywall install, drywall finishing
9. **Interior Finishing** — flooring, interior doors & trim, painting
10. **Final Systems** — electrical fixtures, plumbing fixtures, HVAC commissioning
11. **Final Inspection & Handover** — final inspection, punch list, handover

Chain dates sequentially by default (each phase's start = previous phase's end), using durations that are typical for that phase type unless the user gives their own numbers. Status defaults to "Not Started" for all rows.

Set "Status" as a dropdown-style column if the xlsx skill supports data validation; otherwise plain text is fine.

## Notes

- If the user gives specific dates, budget constraints, or a different phase breakdown, adapt the list to match — don't rigidly force all 11 phases if the project is smaller (e.g. a renovation might skip Foundation/Framing).
- Keep the tone practical — this is a planning tool, not a formal document.