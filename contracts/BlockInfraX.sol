// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BlockInfraX
 * @dev A decentralized registry for managing infrastructure projects on the blockchain.
 */
contract BlockInfraX {
    struct Project {
        uint256 id;
        string name;
        string location;
        address owner;
    }

    uint256 public totalProjects;
    mapping(uint256 => Project) public projects;

    event ProjectRegistered(uint256 indexed id, string name, string location, address indexed owner);
    event OwnershipTransferred(uint256 indexed id, address indexed oldOwner, address indexed newOwner);

    /**
     * @dev Register a new infrastructure project.
     * @param _name Project name.
     * @param _location Project location.
     */
    function registerProject(string memory _name, string memory _location) public {
        totalProjects++;
        projects[totalProjects] = Project(totalProjects, _name, _location, msg.sender);
        emit ProjectRegistered(totalProjects, _name, _location, msg.sender);
    }

    /**
     * @dev Transfer project ownership to a new owner.
     * @param _id Project ID.
     * @param _newOwner Address of the new owner.
     */
    function transferOwnership(uint256 _id, address _newOwner) public {
        require(_id > 0 && _id <= totalProjects, "Invalid project ID");
        Project storage proj = projects[_id];
        require(msg.sender == proj.owner, "Only owner can transfer");
        require(_newOwner != address(0), "Invalid address");

        address oldOwner = proj.owner;
        proj.owner = _newOwner;
        emit OwnershipTransferred(_id, oldOwner, _newOwner);
    }

    /*
     * @dev Get project details.
     * @param _id Project ID.
     * @return id, name, location, owner
     */
    function getProject(uint256 _id)
        public
        view
        returns (uint256 id, string memory name, string memory location, address owner)
    {
        require(_id > 0 && _id <= totalProjects, "Project does not exist");
        Project memory p = projects[_id];
        return (p.id, p.name, p.location, p.owner);
    }
}
