// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BlockInfraX
 * @dev A decentralized infrastructure registry for tracking public projects on the blockchain.
 */
contract BlockInfraX {
    struct Infrastructure {
        uint256 id;
        string name;
        string location;
        address creator;
    }

    uint256 public totalProjects;
    mapping(uint256 => Infrastructure) public infrastructures;

    event InfrastructureAdded(uint256 indexed id, string name, string location, address indexed creator);
    event OwnershipTransferred(uint256 indexed id, address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Add a new infrastructure project.
     * @param _name The name of the infrastructure project.
     * @param _location The location of the project.
     */
    function addInfrastructure(string memory _name, string memory _location) public {
        totalProjects++;
        infrastructures[totalProjects] = Infrastructure(totalProjects, _name, _location, msg.sender);
        emit InfrastructureAdded(totalProjects, _name, _location, msg.sender);
    }

    /**
     * @dev Transfer project ownership to a new address.
     * @param _id The ID of the infrastructure project.
     * @param _newOwner The address of the new owner.
     */
    function transferOwnership(uint256 _id, address _newOwner) public {
        require(_id > 0 && _id <= totalProjects, "Invalid project ID");
        Infrastructure storage infra = infrastructures[_id];
        require(infra.creator == msg.sender, "Only creator can transfer");
        require(_newOwner != address(0), "Invalid address");

        address previousOwner = infra.creator;
        infra.creator = _newOwner;

        emit OwnershipTransferred(_id, previousOwner, _newOwner);
    }

    /**
     * @dev Get details of an infrastructure project.
     * @param _id The ID of the project.
     * @return id, name, location, creator
     */
    function getInfrastructure(uint256 _id) public view returns (uint256, string memory, string memory, address) {
        require(_id > 0 && _id <= totalProjects, "Project does not exist");
        Infrastructure memory infra = infrastructures[_id];
        return (infra.id, infra.name, infra.location, infra.creator);
    }
}
