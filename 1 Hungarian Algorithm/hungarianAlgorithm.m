clc;
clear all;
close all;

% Example usage:
costMatrix = round(10*rand(2,5));
[Agents, Tasks] = size(costMatrix);
if Agents==Tasks
    NewCostMatrix=costMatrix;
    [assignment, totalCost] = hungarianAlgorithm1(NewCostMatrix);
    
elseif Agents>Tasks
    others=-(Tasks-Agents);
    NewCostMatrix=costMatrix;
    NewCostMatrix=[costMatrix,costMatrix(:,1:others)];
    [assignmentNew, totalCost] = hungarianAlgorithm1(NewCostMatrix);
    assignment=assignmentNew(1:Agents);
    assignment=mod(assignment,Tasks);
    for i=1:Agents
        if assignment(i)==0
            assignment(i)=Tasks;
        end
    end
    
elseif Agents<Tasks
    others=Tasks-Agents;
    addingRow=zeros(others,Tasks);
    addingRow(:,:)=0;
    NewCostMatrix=costMatrix;
    NewCostMatrix=[NewCostMatrix;addingRow];
    [assignmentNew, totalCost] = hungarianAlgorithm1(NewCostMatrix);
    assignment=assignmentNew(1:Agents);
end

disp('costMatrix:');
disp(NewCostMatrix);
disp('Optimal Assignment:');
disp(assignment);
disp(['Total Cost: ', num2str(totalCost)]);

function [assignment, totalCost] = hungarianAlgorithm1(costMatrix)
    % HUNGARIAN ALGORITHM
    % Solves the assignment problem for a square cost matrix.
    %
    % Inputs:
    %   costMatrix - A square matrix where costMatrix(i, j) is the cost
    %                of assigning task j to agent i.
    %
    % Outputs:
    %   assignment - A vector where assignment(i) indicates the task assigned to agent i.
    %   totalCost  - The total cost of the optimal assignment.
    
    % Step 1: Subtract row minima
    rowMin = min(costMatrix, [], 2);
    costMatrix = costMatrix - rowMin;
    
    % Step 2: Subtract column minima
    colMin = min(costMatrix, [], 1);
    costMatrix = costMatrix - colMin;
    
    % Step 3: Create initial zero cover
    [numAgents, numTasks] = size(costMatrix);
    coveredRows = false(numAgents, 1);
    coveredColumns = false(numTasks, 1);
    markedZeros = false(numAgents, numTasks); % Zeros marked for assignment
    
    % Mark zeros for potential assignment
    for i = 1:numAgents
        for j = 1:numTasks
            if costMatrix(i, j) == 0 && ~coveredRows(i) && ~coveredColumns(j)
                markedZeros(i, j) = true;
                coveredRows(i) = true;
                coveredColumns(j) = true;
            end
        end
    end
    
    % Clear the row and column coverage for next steps
    coveredRows = false(numAgents, 1);
    coveredColumns = false(numTasks, 1);
    
    % Step 4: Iteratively adjust the matrix until all tasks are assigned
    while sum(markedZeros(:)) < numAgents
        % Find a minimum uncovered value
        uncoveredValues = costMatrix(~coveredRows, ~coveredColumns);
        minUncovered = min(uncoveredValues(:));
        
        % Adjust the matrix
        costMatrix(~coveredRows, ~coveredColumns) = costMatrix(~coveredRows, ~coveredColumns) - minUncovered;
        costMatrix(coveredRows, coveredColumns) = costMatrix(coveredRows, coveredColumns) + minUncovered;
        
        % Update zeros and coverage
        for i = 1:numAgents
            for j = 1:numTasks
                if costMatrix(i, j) == 0 && ~coveredRows(i) && ~coveredColumns(j)
                    markedZeros(i, j) = true;
                    coveredRows(i) = true;
                    coveredColumns(j) = true;
                end
            end
        end
    end
    
    % Step 5: Extract the optimal assignment
    assignment = zeros(numAgents, 1);
    for i = 1:numAgents
        assignedTask = find(markedZeros(i, :), 1);
        assignment(i) = assignedTask;
    end
    
    % Step 6: Calculate the total cost
    totalCost = sum(costMatrix(sub2ind(size(costMatrix), (1:numAgents)', assignment)));
end
