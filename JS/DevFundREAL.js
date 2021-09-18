const address = {
  token: "0x08ed34A3a00899BFbea545929156A5164e820ab4",
};

const abi = {
  token: [
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "newDevAddress",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "monthlyAllowance",
				"type": "uint256"
			}
		],
		"name": "DeveloperAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "deletedDev",
				"type": "address"
			}
		],
		"name": "DeveloperDeleted",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "developer",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "newMonthlyAllowance",
				"type": "uint256"
			}
		],
		"name": "DeveloperUpdated",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address[]",
				"name": "developers",
				"type": "address[]"
			}
		],
		"name": "DevelopersAdded",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "_previousOwner",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "_newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipRenounced",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "_previousOwner",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "address",
				"name": "_newOwner",
				"type": "address"
			}
		],
		"name": "OwnershipTransferred",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address[]",
				"name": "_newDev",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_monthlyAllowance",
				"type": "uint256[]"
			}
		],
		"name": "addDevelopers",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_newManager",
				"type": "address"
			}
		],
		"name": "addManager",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "claim",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "deleteDeveloper",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_deleteManager",
				"type": "address"
			}
		],
		"name": "deleteManager",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "setTGE",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_newOwner",
				"type": "address"
			}
		],
		"name": "transferOwnership",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_newMonthlyAllowance",
				"type": "uint256"
			}
		],
		"name": "updateDeveloper",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "contract IERC20",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "withdrawAnyToken",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "contract IERC20",
				"name": "_token",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"name": "msnDevelopers",
		"outputs": [
			{
				"internalType": "bool",
				"name": "isDeveloper",
				"type": "bool"
			},
			{
				"internalType": "uint256",
				"name": "monthlyAllowance",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "txCount",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "totalClaimed",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "joinedAtTime",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "msnToken",
		"outputs": [
			{
				"internalType": "contract IERC20",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]};
