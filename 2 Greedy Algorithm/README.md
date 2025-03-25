# Greedy Algorithm for Task Assignment

## Scenario
You have a set of agents and a set of tasks. Each agent has a cost associated with performing each task. The goal is to assign tasks to agents such that:
1. **Each task must have at least one agent assigned.**
2. **Each agent can only be assigned to one task.**
3. The total cost is minimized.

---

## Steps for Greedy Approach
1. **Sort all tasks by their cost (ascending order).**
2. **Assign the cheapest available task to the agent who can complete it at the lowest cost.**
3. **Repeat until all tasks are assigned, ensuring no agent is assigned more than one task.**

---

## Example

### Cost Matrix
| Task \ Agent | A1 | A2 | A3 |
|--------------|----|----|----|
| T1           | 9  | 2  | 7  |
| T2           | 6  | 4  | 3  |
| T3           | 5  | 8  | 1  |

---

### Greedy Assignment Process

1. **Step 1: Ensure every task has at least one agent assigned.**
   - For **T1**, assign A2 (lowest cost = 2).
   - For **T2**, assign A3 (lowest cost = 3).
   - For **T3**, assign A3 (lowest cost = 1).

2. **Step 2: Ensure no agent is assigned more than one task.**
   - Adjust assignments to ensure unique agents:
     - **T1** → A2
     - **T2** → A1
     - **T3** → A3

---

### Result
- **Assignment Vector**:
  - Agent 1 → Task 2
  - Agent 2 → Task 1
  - Agent 3 → Task 3

- **Total Cost**:
  - 6 (A1 → T2) + 2 (A2 → T1) + 1 (A3 → T3) = **9**

---

## Notes
- The Greedy Algorithm does not guarantee a globally optimal solution but provides a fast and simple way to minimize costs locally.
- For small matrices or when performance isn't critical, the greedy approach is effective.
- I modified the code so that it can now effectively handle scenarios where the number of agents is greater than the number of tasks, as well as situations where the number of tasks exceeds the number of agents.
