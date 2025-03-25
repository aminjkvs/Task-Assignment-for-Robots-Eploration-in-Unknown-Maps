clc;
clear all;
close all;

% Example usage:
costMatrix = [9 2 7; 6 4 3; 8 8 1; 5 6 4; 7 5 2]; % 5 agents and 3 tasks
[Agents, Tasks] = size(costMatrix);
[assignmentNew, totalCost] = greedyAlgorithmWithTaskConstraint(costMatrix);

for i=1:Agents
    if assignmentNew(i)==0
        check=costMatrix(i,:);
        [minValue,minIndx]=min(check);
        assignmentNew(i)=minIndx;
    end
end
disp('costMatrix:');
disp(costMatrix);
disp('Optimal Assignment:');
disp(assignmentNew);
disp(['Total Cost: ', num2str(totalCost)]);

function [assignment, totalCost] = greedyAlgorithmWithTaskConstraint(costMatrix)
    % GREEDY ALGORITHM (NO DUPLICATE TASKS PER AGENT)
    % Solves the assignment problem such that:
    % 1. Each task must have at least one agent assigned.
    % 2. Agents cannot be assigned to more than one task.
    %
    % Inputs:
    %   costMatrix - A matrix where costMatrix(i, j) is the cost
    %                of assigning task j to agent i.
    %                Size: (numAgents x numTasks)
    %
    % Outputs:
    %   assignment - A vector where assignment(i) indicates the task assigned to agent i.
    %                If assignment(i) = 0, agent i is unassigned.
    %   totalCost  - The total cost of the assignment.

    [numAgents, numTasks] = size(costMatrix);

    % Initialize assignment vector
    assignment = zeros(numAgents, 1); % Each agent initially unassigned
    totalCost = 0;

    % Keep track of which tasks are assigned
    assignedTasks = false(1, numTasks);

    % Step 1: Assign tasks greedily
    for task = 1:numTasks
        % Find the agent with the minimum cost for this task
        [minCost, agent] = min(costMatrix(:, task));
        while assignment(agent) ~= 0 % Ensure the agent is not already assigned
            % Temporarily set this cost to infinity to avoid reassigning the same agent
            costMatrix(agent, task) = inf;
            [minCost, agent] = min(costMatrix(:, task));
        end
        % Assign the agent to the task
        assignment(agent) = task;
        assignedTasks(task) = true;
        totalCost = totalCost + minCost; % Add the cost to the total
    end

    % Step 2: Handle extra agents (agents left unassigned)
    for agent = 1:numAgents
        if assignment(agent) == 0
            % This agent is unassigned; they will remain unassigned
            % No additional cost is added
        end
    end
end
