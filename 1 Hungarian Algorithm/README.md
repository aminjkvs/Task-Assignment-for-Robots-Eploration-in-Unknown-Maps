# Hungarian Algorithm for Task Assignment

## Scenario
The Hungarian Algorithm is used to solve the assignment problem optimally. It minimizes the total cost while ensuring:
1. **Each agent is assigned exactly one task.**
2. **Each task is assigned to exactly one agent.**
3. **No duplication of tasks or agents is allowed.**

The Hungarian Algorithm guarantees an optimal solution for the assignment problem, even when the number of agents exceeds or matches the number of tasks.

---

## Steps for the Hungarian Algorithm

1. **Ensure the cost matrix is square**:
   - If the number of agents exceeds the number of tasks, add dummy tasks with zero cost to balance the matrix.
   
2. **Subtract row minima**:
   - For each row in the matrix, subtract the smallest value in that row from all entries in that row.

3. **Subtract column minima**:
   - For each column in the matrix, subtract the smallest value in that column from all entries in that column.

4. **Cover all zeros with the minimum number of lines**:
   - Use horizontal and vertical lines to cover all zeros in the matrix.

5. **Adjust the matrix**:
   - If the minimum number of lines is less than the matrix size, adjust the matrix by subtracting the smallest uncovered value from uncovered elements and adding it to covered elements.

6. **Repeat**:
   - Repeat the process until the number of lines equals the matrix size.

7. **Extract the assignment**:
   - Once all zeros are covered, find the optimal assignment by selecting zeros such that no row or column is used more than once.

---

## Example

### Cost Matrix
| Task \ Agent | A1 | A2 | A3 |
|--------------|----|----|----|
| T1           | 9  | 2  | 7  |
| T2           | 6  | 4  | 3  |
| T3           | 5  | 8  | 1  |

---

### Hungarian Algorithm Process

1. **Step 1: Subtract Row Minima**
   - Subtract the smallest value in each row:
     - Row 1: `[9-2, 2-2, 7-2] → [7, 0, 5]`
     - Row 2: `[6-3, 4-3, 3-3] → [3, 1, 0]`
     - Row 3: `[5-1, 8-1, 1-1] → [4, 7, 0]`

2. **Step 2: Subtract Column Minima**
   - Subtract the smallest value in each column:
     - Column 1: `[7-3, 3-3, 4-3] → [4, 0, 1]`
     - Column 2: `[0-0, 1-0, 7-0] → [0, 1, 7]`
     - Column 3: `[5-0, 0-0, 0-0] → [5, 0, 0]`

3. **Step 3: Cover Zeros with Minimum Lines**
   - Cover all zeros in the matrix using horizontal and vertical lines.

4. **Step 4: Adjust the Matrix**
   - If the number of lines is less than the matrix size, adjust the matrix.

5. **Step 5: Extract Optimal Assignment**
   - Assign tasks based on uncovered zeros, ensuring no row or column is used more than once.

---

### Result
- **Assignment Vector**:
  - Agent 1 → Task 2
  - Agent 2 → Task 3
  - Agent 3 → Task 1

- **Total Cost**:
  - 2 (A1 → T2) + 3 (A2 → T3) + 5 (A3 → T1) = **10**

---

## Notes
- The Hungarian Algorithm guarantees an **optimal solution**.
- It is computationally efficient, especially for square matrices.
- If the number of agents exceeds the number of tasks, dummy tasks are added with zero cost.
