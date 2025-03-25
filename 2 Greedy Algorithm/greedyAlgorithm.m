clc;
clear all;
close all;

% Example usage:
costMatrix = round(10*rand(5,5)); % 5 agents and 3 tasks
[Agents, Tasks] = size(costMatrix);
NewCostMatrix=costMatrix;
if Agents<Tasks
    others=Tasks-Agents;
    addingRow=zeros(others,Tasks);
    addingRow(:,:)=999;
    NewCostMatrix=[NewCostMatrix;addingRow];
end
[assignmentNew, totalCost] = greedyAlgorithmWithTaskConstraint(NewCostMatrix);

for i=1:Agents
    if assignmentNew(i)==0
        check=costMatrix(i,:);
        [minValue,minIndx]=min(check);
        assignmentNew(i)=minIndx;
    end
end
disp('costMatrix:');
disp(NewCostMatrix);
disp('Optimal Assignment:');
disp(assignmentNew);
disp(['Total Cost: ', num2str(totalCost)]);

function [assignment, totalCost] = greedyAlgorithmWithTaskConstraint(costMatrix)

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
