# Armor Type Overhaul — Modular Design Document (Spec‑Complete v2.4)

> **Module:** Armor Type Overhaul\
> **Scope:** Light/Medium/Heavy armor frameworks, global/clothing tags\
> **Depends On:** Script Extender (SE), BG3 Community Library (CL), Compatibility Framework (CF)\
> **Provides:** Custom statuses (e.g., MOD\_Disoriented), passives, reactions, auras\
> **Spec Format:** Type · Trigger · Effect · Duration · Cooldown\
> **Reference Markers:** [E#] → Engine Notes appendix

---

> **Project Actions (2025-10-28):**
>
> - Archived v2.2; **v2.4** is now the single source of truth.
> - Initialize repo per **Appendix D** structure.
> - Create placeholder dirs/files: `/Data`, `/Public`, `/Scripts`, `/docs`, `/tools`.

## 0) Global Conventions

- **m** = meters. **Round** = full initiative cycle. **Turn** = the active creature’s turn.
- **Adjacency (default)** = 3 m; if explicitly 1.5 m, use that.
- **OA (Opportunity Attack)** = triggered when a creature moves out of your melee reach.
- **Start/End of Turn:** as previously specified.
- When forced movement is < 1 m after reductions, **no movement** occurs.

---

## 1) Armor Frameworks

### 1.1) Light Armor — *Skirmisher / Tempo*

**Base Effects**

- Advantage on Initiative; +1 m Movement; add full DEX to AC; **Skirmisher’s Step** (Bonus Action: Disengage)

**Commons (15)**

**Lone Wolf** Type: Passive Trigger: End of your turn with no ally within 8 m Effect: +1 to‑hit on your next turn; stacks to +2; resets if you end any turn with an ally within 8 m Duration: Until start of your next turn Cooldown: —

**Shadowstep** Type: Passive Trigger: After Dash/Disengage/Hide (main action only) Effect: Bank “Momentum”; your next attack within 2 turns has Advantage (max 1 bank) Duration: 2 turns or until consumed Cooldown: —

**Riposte** Type: Reaction (1/round) Trigger: A melee attack misses you Effect: Make a counterattack; on hit, gain +1 AC Duration: Until start of your next turn (AC bonus) Cooldown: —

**Trickster** Type: Passive Trigger: You cast a cantrip Effect: +1 AC Duration: 1 turn Cooldown: —

**Duelist** Type: Passive Trigger: You moved < 6 m this turn Effect: +1.5 m Movement on your next turn (stacks to +3 m) Duration: Until start of your next turn Cooldown: —

**Cornered Cat** Type: Passive Trigger: You are adjacent (3 m) to ≥2 enemies Effect: +1 AC per adjacent enemy (max +3 AC) Duration: While condition persists (re‑evaluated at end of your turn) Cooldown: —

**Cut & Run** Type: Free movement Trigger: You hit with a melee attack Effect: Gain free 3 m movement (does not provoke OAs) Duration: Immediate Cooldown: Once/turn

**Needle** Type: On‑hit rider Trigger: Your attack hits Effect: Apply Bleed (1 turn) Duration: 1 turn (Bleed) Cooldown: —

**Evasive Step** Type: Reactive buff Trigger: You take damage Effect: +3 m Movement Duration: Until end of your next turn Cooldown: Once/turn

**Deadeye** Type: Bonus Action Trigger: — Effect: Mark a target within 18 m; your next attack vs it gains +2 to‑hit Duration: Until start of your next turn or consumed Cooldown: —

**Low Profile** Type: Passive Trigger: End your turn Stealthed (not Revealed) Effect: Heal +2 HP per character level Duration: Immediate (end of your turn) Cooldown: —

**Opportunist** Type: Passive (OA rider) Trigger: — Effect: Your OAs deal +PB damage; from level 5, your OAs have Advantage Duration: — Cooldown: —

**Ambusher** Type: On‑hit rider Trigger: You hit an enemy that hasn’t acted yet this combat Effect: Apply Disoriented (–1 AC & Disadvantage on checks) until the end of that enemy’s first turn Duration: Until end of that enemy’s first turn Cooldown: —

**Vanish** Type: Utility Trigger: — Effect: Hide becomes a Bonus Action; gain Advantage on Stealth checks Duration: — Cooldown: —

**Slinger [E1]** Type: Thrown‑weapon quality‑of‑life Trigger: — Effect: Thrown daggers gain +2 m range and Advantage on attack rolls; return to inventory on hit (not auto‑equipped) Duration: — Cooldown: —

**Mythics (6)**

**Phantom Step** Type: Disengage upgrade Trigger: You Disengage Effect: Teleport up to 3 m and gain Advantage on your next weapon attack Duration: Until start of your next turn or consumed Cooldown: —

**Blinkguard [E2]** Type: Reaction Trigger: You are targeted by an attack Effect: Add +10 AC vs the incoming attack; then teleport randomly 3–5 m to safe terrain Duration: Immediate Cooldown: 1/fight

**Energetic** Type: Passive Trigger: — Effect: Gain Action Surge (does not stack with Fighter’s Action Surge) Duration: — Cooldown: 1/Long Rest

**Knife’s Edge** Type: Threshold buff Trigger: You are at ≤50% HP (or ≤25% HP) Effect: At ≤50% HP: +2 to‑hit and +2 AC; at ≤25% HP: +4 to‑hit and +4 AC Duration: While threshold condition persists Cooldown: —

**Calculated [E3]** Type: Reaction upgrade Trigger: — Effect: Advantage on reaction attack rolls; add +PB to damage; on a miss, deal ½ damage Duration: — Cooldown: —

**Glass Dancer** Type: Risk‑reward passive Trigger: You move > 6 m in a turn (while in combat) Effect: You take PB × 2 force damage; your weapon attacks deal PB × 2 additional damage Duration: Per‑turn condition Cooldown: —

### 1.2) Medium Armor — *Control / Anchor*

**Base Effects**

- Add DEX to AC (max +2); –1 Physical DR; Advantage vs Shove/Prone; **Brace** Reaction: when a creature enters your melee reach (1.5 m), reduce its remaining movement by 3 m (1/round)

**Commons (15)**

**Warden** Type: Passive aura (3 m) Trigger: Enemies end their turn within 3 m Effect: Those enemies lose 3 m Movement on their next turn Duration: Next turn (of each affected enemy) Cooldown: —

**Bulwark** Type: Passive aura (1.5 m → 3 m on damage taken) Trigger: — / Taking damage Effect: Adjacent (1.5 m) allies gain +1 AC; when you take damage, aura expands to 3 m until end of your next turn Duration: Persistent; 3 m expansion lasts 1 turn Cooldown: —

**Sentinel** Type: Passive Trigger: — Effect: +1 extra Reaction per round (OA‑only); shares pools with other extra‑reaction sources Duration: — Cooldown: —

**Vanguard [E4]** Type: Passive toggle Trigger: Your first hit each round Effect: Attempt to push 3 m (STR save DC 15 to resist) Duration: Immediate Cooldown: —

**Clip Their Wings [E5]** Type: OA rider Trigger: Your Opportunity Attack hits Effect: Target must succeed a DEX save or lose 6 m Movement next turn if base Move > 6 m; otherwise lose 3 m Duration: Next turn (of the target) Cooldown: —

**Rallying Cry** Type: Passive Trigger: You take a critical hit Effect: Allies within 6 m gain Temp HP equal to PB Duration: Immediate Cooldown: —

**Hold the Line** Type: Passive aura (1.5 m / 3 m) Trigger: Creatures end their turn within 1.5 m or within 3 m Effect: Within 1.5 m: –2 to‑hit until end of their next turn; within 3 m: –1 to‑hit until end of their next turn Duration: Until end of each affected creature’s next turn Cooldown: —

**Zone of Control** Type: Reaction (1/round) Trigger: An enemy enters adjacency (3 m) Effect: You may step 1.5 m and make an Opportunity Attack Duration: Immediate Cooldown: —

**Steadfast** Type: Passive Trigger: — Effect: +2 on Constitution saving throws to maintain Concentration; while concentrating, gain 1 DR Duration: — Cooldown: —

**Harrier** Type: On‑hit rider Trigger: You hit with a melee attack Effect: Target cannot Jump or Shove on its next turn Duration: Next turn (of the target) Cooldown: —

**Rallying Roar** Type: Bonus Action Trigger: — Effect: Allies within 6 m gain +1 to‑hit and +1 damage Duration: 1 turn Cooldown: 1/fight

**Stalwart** Type: Passive Trigger: — Effect: Advantage on saves vs forced movement Duration: — Cooldown: —

**Shield Wall** Type: Passive (requires shield) Trigger: Adjacent (3 m) to an ally with a shield Effect: You and that ally gain +1 AC and –1 DR Duration: While condition persists Cooldown: —

**Tactical Aid** Type: Bonus Action Trigger: — Effect: Grant an ally within 5 m +2 to their next attack Duration: Until start of your next turn or consumed Cooldown: —

**Bash and Bind** Type: Passive + rider Trigger: After you successfully Shove a target Effect: Your weapon attacks against that target have Advantage Duration: Until end of your next turn Cooldown: —

**Mythics (6)**

**Bastion** Type: Aura (5 m, pulse at start of your turn) Trigger: — Effect: Allies in aura heal 1d4 + PB and gain +1 to WIS saves Duration: Until end of each affected ally’s next turn Cooldown: —

**Iron Grasp** Type: OA rider Trigger: Your Opportunity Attack hits Effect: On failed DEX save, target’s speed becomes 0 for the current turn; on success, remove half of its total movement (rounded down) Duration: Current turn (speed 0) / immediate (movement removal) Cooldown: —

**Warcry** Type: Bonus Action Trigger: — Effect: Allies within 6 m gain +1 to‑hit, Advantage on weapon actions, and +1 Bonus Action for 1 turn (excluding you) Duration: 1 turn Cooldown: 1/fight

**Opportunist** Type: Passive Trigger: Enemy starts its turn adjacent (3 m) Effect: That enemy provokes an Opportunity Attack from you (consumes a reaction) Duration: Immediate Cooldown: —

**Anchor Point** Type: Reaction (1/round) Trigger: An ally within 8 m would be force‑moved Effect: Negate the forced movement Duration: Immediate Cooldown: —

**Suppressing Stance [E6]** Type: Passive Trigger: Your melee weapon attack hits a concentrating enemy Effect: Always breaks Concentration; if Concentration is lost this way, double the damage of that attack Duration: Immediate (damage doubling applies to that attack) Cooldown: —

### 1.3) Heavy Armor — *Fortress / Guard*

**Base Effects**

- No DEX to AC; –2 Physical DR; forced‑movement reduced by 2 m (immune if <1 m); Jump costs Action; Disadvantage on Initiative; **Guard** Reaction: when hit, reduce damage by STR mod + PB for that attack only.

**Commons (15)**

**Juggernaut** Type: Passive Trigger: After you perform an Action Jump Effect: Gain Temp HP equal to PB Duration: 1 turn Cooldown: —

**Guardian** Type: Reaction (1/round) Trigger: An ally within 3 m is targeted by an attack Effect: Impose Disadvantage on that attack Duration: Immediate Cooldown: —

**Unstoppable** Type: Passive Trigger: First time you drop below 50% HP each fight Effect: Clear disabling effects (stun, prone, restraint, charm, fear, etc.) Duration: Immediate Cooldown: —

**Tyrant** Type: Passive Trigger: You kill or down an enemy Effect: Enemies within 5 m must succeed a WIS save (DC = 8 + PB + CHA) or become Frightened Duration: 1 turn (on failed save) Cooldown: —

**Defiant** Type: Reactive rider Trigger: An enemy attempts to force‑move you Effect: That enemy takes damage equal to 2 × PB Duration: Immediate Cooldown: Once/turn

**Stonewall** Type: Passive Trigger: You moved < 1.5 m on your last turn Effect: Gain +1 DR Duration: This turn Cooldown: —

**Bodyguard** Type: Reaction (1/round) Trigger: An adjacent (3 m) ally would take damage from one instance Effect: You take half of that damage instead Duration: Immediate Cooldown: —

**Punishing Guard [E7]** Type: Rider to Guard Trigger: Guard reduces damage from an attack Effect: Attacker must succeed a DEX save (DC 15) or take PB damage Duration: Immediate Cooldown: —

**Confident** Type: Passive Trigger: You end your turn adjacent to ≥2 enemies Effect: +1 to‑hit and +1 DR Duration: 1 turn Cooldown: —

**Intimidation Aura** Type: Passive aura (3 m) Trigger: — Effect: Enemies have –1 to‑hit (–2 at level 5) unless they target you Duration: While in aura / until end of their turn after leaving Cooldown: —

**Iron Heel** Type: OA rider Trigger: Your Opportunity Attack hits Effect: Target has Disadvantage Duration: 1 turn Cooldown: —

**Steel Mind** Type: Passive + rider Trigger: You succeed on a WIS saving throw Effect: Stagger the source: –3 m Movement and –1 to‑hit until end of its current turn; you also gain +1 to WIS saves (passive) Duration: Until end of source’s current turn (stagger) Cooldown: —

**Lockstep** Type: Passive Trigger: Adjacent (3 m) to an ally wearing medium or heavy armor Effect: You and that ally gain +1 AC Duration: While condition persists Cooldown: —

**Stabilize** Type: Reaction (1/battle) Trigger: You would take a critical hit Effect: Reduce the damage to normal damage Duration: Immediate Cooldown: 1/fight

**Shield Bash** Type: Passive rider (requires shield raised) Trigger: Your melee weapon attack hits Effect: Also Shove the target 3 m (resolve saves per Shove rules) Duration: Immediate Cooldown: —

**Mythics (6)**

**Guardian’s Interpose** Type: Reaction (1/fight) Trigger: An adjacent (3 m) ally is attacked Effect: Swap positions; you become the target and auto‑Guard that attack Duration: Immediate Cooldown: 1/fight

**Taunt** Type: Action (1/fight) Trigger: — Effect: In a 6 m cone, each enemy must succeed a WIS save (DC = 8 + PB + CHA) or must target you Duration: Until start of your next turn Cooldown: 1/fight

**Aegis [E8]** Type: Passive stacks (max 3) Trigger: You take damage (each instance) Effect: Gain 1 Steadfast; at 3 stacks, your next Guard does not consume a reaction (consumes all stacks) Duration: Stacks persist until expended Cooldown: —

**Earthshaker** Type: Action (1/fight) Trigger: — Effect: Slam to create a 5 m crater of Difficult Terrain; enemies in the zone become Slowed Duration: 2 turns (Slow) Cooldown: 1/fight

**Last Stand** Type: Passive safety Trigger: The first time you would drop to 0 HP (per fight) Effect: Remain at 1 HP and gain Temp HP equal to PB Duration: Immediate Cooldown: 1/fight

**Unyielding Challenge** Type: Bonus Action Trigger: — Effect: Mark an enemy within 8 m; they have Disadvantage vs allies and Advantage vs you Duration: Until start of your next turn Cooldown: —

---

## 2) Global Tags

**Commons (10)**

**Element Ward** Type: Start‑of‑combat buff Trigger: Combat starts Effect: Gain one random elemental resistance Duration: 3 rounds Cooldown: —

**Second Wind** Type: Bonus Action Trigger: — Effect: Heal PB Duration: Immediate Cooldown: 1/fight

**Battle Scholar** Type: On‑heal rider Trigger: You heal an ally with a spell Effect: You and that ally gain Advantage on your next attack Duration: Until start of your next turns or consumed Cooldown: —

**Potion Master** Type: First‑potion rider Trigger: You consume your first potion of the fight Effect: Gain +1 Bonus Action and Temp HP equal to PB Duration: Immediate (Temp HP persists as normal) Cooldown: —

**Rush of Battle** Type: First‑hit rider Trigger: Your first hit of the fight Effect: +3 m Movement Duration: 2 turns Cooldown: —

**Hawkeye** Type: Passive Trigger: — Effect: Ranged weapon attacks and cantrips against you suffer –1 to‑hit Duration: — Cooldown: —

**Spell Buffer [E9]** Type: Passive Trigger: The first hostile spell that hits you each fight Effect: Gain Temp HP equal to PB Duration: Immediate Cooldown: 1/fight

**Sonic Step** Type: Dash rider Trigger: You Dash (full action only) Effect: Allies within 5 m gain Advantage on their next attack Duration: Until start of their next turn or consumed Cooldown: —

**Blood Price** Type: Reaction (1/fight) Trigger: You score a critical hit Effect: Double the damage of that attack; then you take half of the total damage dealt (after doubling) Duration: Immediate Cooldown: 1/fight

**Lucky Break [E10]** Type: Reaction (1/fight) Trigger: — Effect: Gain Graze Window for 1 round; your next miss this round deals ½ damage Duration: 1 round Cooldown: 1/fight

**Rares (5, solo global)**

**Buzzed** Type: Activated buff Trigger: — Effect: Gain +1 Bonus Action and +1 Reaction for 1 turn Duration: 1 turn Cooldown: 1/fight

**Sanctuary Ward** Type: Aura (3 m) Trigger: An ally (not you) within 3 m would drop to 0 HP Effect: They instead drop to 1 HP (first time each fight) Duration: Immediate Cooldown: 1/fight

**Arcane Siphon** Type: On‑kill rider Trigger: You defeat an enemy Effect: Regain 1 expended level‑1 spell slot Duration: Immediate Cooldown: 1/fight

**Momentum** Type: Passive Trigger: You hit a new enemy this combat Effect: +1 m Movement for the rest of the fight (stacks to +5) Duration: Remainder of combat Cooldown: —

**Lucky Charm** Type: Start‑of‑combat buff Trigger: Combat starts Effect: Gain one random effect until combat ends: +2 AC, +2 to‑hit, +3 m Movement, or Temp HP = PB Duration: Until end of combat Cooldown: —

---

## 3) Clothing Tags

**Arcanist** Type: Casting rider Trigger: You cast your first cantrip of the combat Effect: That cantrip is cast as a Bonus Action Duration: Immediate Cooldown: 1/combat

**Ascetic** Type: Passive (conditioned) Trigger: — Effect: If unarmed (no shield), cantrips/spells +1 to‑hit and +1 damage (+3 damage at level 5+); +1 AC Duration: — Cooldown: —

**Flow (Mythic) [E11]** Type: Post‑cast rider Trigger: After casting a level‑1+ spell in combat Effect: Gain Focus: your next cantrip/unarmed/weapon attack has Advantage Duration: Until start of your next turn or consumed Cooldown: —

---

## 4) Implementation Notes & Modular Design Framework

### Engine Notes

[E1] **Thrown weapon control:** Implement via Community Library return‑to‑inventory flag or Returning Weapon mod logic; disable auto‑equip.\
[E2] **Blinkguard teleport:** Use Script Extender safe‑tile teleport; reject lava/void tiles; randomize within 3–5 m radius.\
[E3] **Reaction advantage logic:** Use custom roll override to ensure Advantage and half‑damage (graze) on miss.\
[E4] **Push toggle:** Implement via PassiveData toggle flag; controlled via Custom Passives Library for runtime on/off.\
[E5] **Movement penalty:** Apply as MovementReduction status; scale with target’s base speed.\
[E6] **Concentration break:** Use Concentration tag hook; if break event triggers, apply double damage multiplier via Osiris event.\
[E7] **Guard rider:** Attach extra effect to Guard passive; trigger OnDamageReduced; apply PB damage through EventDamage.\
[E8] **Stack logic:** Manage via PersistentStatus; auto‑consume stacks on next Guard.\
[E9] **Spell Buffer:** Apply one‑time trigger per combat; use CombatStart/HitListener to ensure single activation.\
[E10] **Graze Window:** Create temporary buff; modify attack damage output for next miss.\
[E11] **Focus state:** Implement as Advantage buff with expiry at next turn start.

---

### 5) Modular Expansion Notes (Project‑Wide Reference)

- Maintain this format for all future core‑system mods (Armor, Weapons, Spells, Conditions, Feats, etc.).
- Each new system should have a **Spec‑Complete** baseline document with numbered Engine Notes and global conventions.
- When adding new custom statuses, prefix with **MOD\_** to avoid namespace collisions.
- Prefer **Compatibility Framework** list injection for passives/conditions instead of editing vanilla Progressions.
- Track versioning in the changelog using **semantic versioning** (major.minor.patch).
- Reference all libraries (SE, CL, CF) and required Nexus dependencies in an appendix.

---

## Appendix A — Dependencies & Versioning

**Required:**

- **Script Extender (SE)** — min ver: *TBD*
- **BG3 Community Library (CL)** — min ver: *TBD*
- **Compatibility Framework (CF)** — min ver: *TBD*

**Optional (Dev/QA):**

- Reaction Points on Hotbar (for tester visibility)
- Returning Weapon QoL (if not implementing [E1] in‑house)

**Versioning Policy:**

- **MAJOR:** breaking behavior or data contract changes
- **MINOR:** backwards‑compatible additions/flags
- **PATCH:** fixes and non‑behavioral text/tooltip changes

**Release Artifacts:**

- `/dist/ArmorTypeOverhaul.pak`, README.md, CHANGELOG.md, LICENSE, module meta (UUIDs)

---

## Appendix B — Changelog Template

```
## [x.y.z] — 2025‑MM‑DD
### Added
-
### Changed
-
### Fixed
-
### Removed
-
### Engine Notes (if any)
-
```

---

## Appendix C — Module & Namespace Registry

- **Module UUID:** *TBD*
- **Primary Status Prefix:** `MOD_`
- **Lua Namespace:** `ATO_*` (Armor Type Overhaul)
- **Osiris Goals File:** `ATO_ArmorGoals`
- **Tag IDs:** see `/docs/ids/ato_ids.json`

---

## Appendix D — Build, Test, and QA

**Repo Layout (suggested):**

```
/ArmorTypeOverhaul
  /Data
  /Public
  /Scripts
  /docs
  /tools
```

**CI Checks:** schema lint for data tables; UUID stability; cross‑module reference resolver.

**QA Scenarios:**

- Start/end combat triggers; reaction pool edge cases (extra OA only).
- Concentration break → damage double order of operations.
- Teleport safety net; free‑movement OA behavior.

---

**v2.4:** Converted doc to **Armor Type Overhaul** module; added appendices for dependencies, versioning, changelog, registry, and build/QA; promoted Modular Expansion Notes to a project‑wide section with reference markers.

