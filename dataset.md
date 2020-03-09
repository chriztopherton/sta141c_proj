# SkillCraft1_Dataset.csv
  
  
  
**Source**

The dataset is from the UC Irvine Machine Learning Repository, donated by Mark Blair, Joe Thompson, Andrew Henrey, and Bill Chen from the Department of Psychology; Simon Fraser University; Burnaby. 


**Description**

SkillCraft1_Dataset.csv contains the dataset of twenty variables for each of the 3395 Starcraft 2 games, played in different leagues/levels. The variables include Game ID, League Index, age, hours played per week, total hours played, actions per minute, select by hotkeys, assign by hotkeys, unique hotkeys, minimap attacks, minimap right clicks, number of PACs, gap between PACs, action latency, actions in PAC, total map explored, workers made, unique units made, complex units made, and complex abilities used. Screen movements aggregated into screen-fixations. Time is recorded in terms of timestamps in the StarCraft 2 replay file. When the game is played on 'faster', 1 real-time second is equivalent to roughly 88.5 timestamps.



**Format**

- GameID: Unique ID number for each game (integer)

- LeagueIndex: Bronze, Silver, Gold, Platinum, Diamond, Master, GrandMaster, and Professional leagues coded 1-8 (Ordinal)
  
- Age: Age of each player (integer)

- HoursPerWeek: Reported hours spent playing per week (integer)

- TotalHours: Reported total hours spent playing (integer)

- APM: Action per minute (continuous)

- SelectByHotkeys: Number of unit or building selections made using hotkeys per timestamp (continuous)

- AssignToHotkeys: Number of units or buildings assigned to hotkeys per timestamp (continuous)

- UniqueHotkeys: Number of unique hotkeys used per timestamp (continuous)

- MinimapAttacks: Number of attack actions on minimap per timestamp (continuous)

- MinimapRightClicks: number of right-clicks on minimap per timestamp (continuous)

- NumberOfPACs: Number of PACs per timestamp (continuous)

- GapBetweenPACs: Mean duration in milliseconds between PACs (continuous)

- ActionLatency: Mean latency from the onset of a PACs to their first action in milliseconds (continuous)

- ActionsInPAC: Mean number of actions within each PAC (continuous)

- TotalMapExplored: The number of 24x24 game coordinate grids viewed by the player per timestamp (continuous)

- WorkersMade: Number of SCVs, drones, and probes trained per timestamp (continuous)

- UniqueUnitsMade: Unique unites made per timestamp (continuous)

- ComplexUnitsMade: Number of ghosts, infestors, and high templars trained per timestamp (continuous)

- ComplexAbilitiesUsed: Abilities requiring specific targeting instructions used per timestamp (continuous)


