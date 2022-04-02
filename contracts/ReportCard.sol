// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ReportCard {

//Report Card provides snapshot of task list, completed tasks and completion points earned 
// With the ToDoList.sol as base, I have incorporated the following refinements:
// (i) struct includes additional property points : each task is identified by specific points
// (ii) the is a new function to calculate the total points earned from completed task
// (iii) all these are reflected in the updated front end   

    struct Task {
        string task_name;
        uint256 points; 
        bool is_done;
    }

    // Create a dictionary with address as key, and array of Tasks as value
    mapping (address => Task[]) private Users;

    function addTask (string calldata _task, uint256 _points) external {
        Users[msg.sender].push(Task({
            task_name: _task,
            points: _points,
            is_done: false
        }));
    }

    function getTask (uint _taskIndex) external view returns (Task memory) {
        Task memory task = Users[msg.sender][_taskIndex];
        return task;
    }

    function updateTaskStatus (uint _taskIndex, bool _status) external {
        Users[msg.sender][_taskIndex].is_done = _status;
    }

    function deleteTask (uint _taskIndex) external {
        delete Users[msg.sender][_taskIndex];
    }

    function getTaskCount() external view returns (uint256) {
        return Users[msg.sender].length;
    }

    function getTaskPoints() external view returns (uint256) {
         uint256 totalPoints = 0;
         for (uint i = 0; i < Users[msg.sender].length; i++ ) {
             if (Users[msg.sender][i].is_done == true){
                totalPoints = totalPoints + Users[msg.sender][i].points;
             } 
         }
        return totalPoints;
    }
}
