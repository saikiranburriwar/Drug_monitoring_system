/**
 *Submitted for verification at Etherscan.io on 2022-04-19
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.8.0;

contract Supplychain{

    address owner;
   
   constructor() public {
      owner = msg.sender;
   }

uint256 product_id=0;
uint256 worker_id=0;

struct Product{
    uint256 id;
    string name;
    string price;
    string description;
    string reqtemp;
    string manufacturing;
    uint256 timestamp;
}

struct Status{
    string location;
    uint256 timestamp;
    string temp;
    string humidity;
    string heatindex;
    uint256 w_id;
    uint256 p_id;
    uint256 total_quantity;
    bool flag;
}

struct Worker{
    string name;
    uint256 id;
    uint256 timestamp;
}

struct Data {
    uint256 temp;
    uint256 humidity;
    uint256 hindex;
    uint256 pid;
}

modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

Product[] public drugs_list;
Product private drugsInfo;
Status[] public drugStatus;
Status private statusData;
Worker[] public employees_list;
Worker private employeeInfo;
Data[] public Drug_List;
Data private DrugInfo;


mapping(uint256 => Status[]) public drug_status;
mapping (uint256 => Product) public drugs;
mapping (uint256 => Worker) public employees;
mapping (uint256 => Data[]) public data;


function setEmployee(string memory name) public  payable
{
    employeeInfo=Worker(name,worker_id,block.timestamp);
    employees[worker_id]=employeeInfo;
    employees_list.push(employeeInfo);
    worker_id++;

}

function AddDrug(
    string memory name,
    string memory price,
    string memory description,
    string memory reqtemp,
    string memory manufacturing) public payable
{
    drugsInfo=Product(product_id,name,price,description,reqtemp,manufacturing,block.timestamp);
    drugs[product_id]=(drugsInfo);
    drugs_list.push(drugsInfo);
    product_id++;

}

function AddDrugStatus( string memory location,
    
    string  memory temp,
    string  memory humidity,
    string  memory heatindex,
    uint256 wid,
    uint256 pid,
    uint256 total_quantity,
    bool flag
) public payable {

    statusData= Status(location,block.timestamp,temp,humidity,heatindex,wid,pid,total_quantity,flag);
    drug_status[pid].push(statusData);
    drugStatus.push(statusData);
}


function AddDrugData( uint256 temp,
    uint256 humidity,
    uint256 hindex,uint256 pid) public payable {

        DrugInfo = Data(temp,humidity,hindex,pid);
        data[pid].push(DrugInfo);
        Drug_List.push(DrugInfo);
        }
function getEmployeesList() public view returns(Worker[] memory)
{
    return employees_list;
}

function getDrugStatus(uint256 id) public view returns(Status[] memory){

    return drug_status[id];
}

function getDrugData(uint256 id) public view returns(Data[] memory){

    return data[id];
}

function getDrugs() public view returns(Product[] memory){

    return drugs_list ;
}


}