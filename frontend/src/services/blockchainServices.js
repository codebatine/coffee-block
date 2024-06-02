import { ethers } from 'ethers';
import {
  DEPLOYER_CONTRACT,
  SENDER_CONTRACT,
  abi_a,
  abi_b,
  abi_ccip_sender,
  abi_ccip_receiver,
  CHAIN_SELECTOR,
  RECIEVER_CONTRACT,
} from './config.js';

const provider = new ethers.BrowserProvider(window.ethereum);

// WALLET FUNCTIONS

export const requestAccount = async () => {
  console.log('1');

  try {
    console.log('2');

    const result = await window.ethereum.request({
      method: 'eth_requestAccounts',
    });
    return result;
  } catch (error) {
    console.error('Error requesting account:', error);
  }
};

export const walletChecker = (errorMsg) => {
  if (!window.ethereum) {
    errorMsg =
      'Ethers.js: Web3 provider not found. Please install a wallet with Web3 support.';
    console.error(errorMsg);
  } else {
    window.provider = new ethers.BrowserProvider(window.ethereum);
  }
};

export const getAddress = async () => {
  try {
    const accountAdressArray = await window.ethereum.request({
      method: 'eth_accounts',
      params: [],
    });
    const accountAdress = accountAdressArray[0];

    return accountAdress;
  } catch (error) {
    console.log(error);
  }
};

// CONTRACT FUNCTIONS

// create contract

export const getProjctOwner = async () => {
  try {
    const contactAddress = '0x68B0fcF47729688097709d98Fa4DEc4643A96959';
    const writeContract = await loadWriteContract_b(contactAddress);
    const projectOwner = await writeContract.i_owner();
    const usdcAddress = await writeContract.getUsdAddress();
    const lowcaseOwner = projectOwner.toLowerCase();
    console.log('!usdcAddress', usdcAddress);
    console.log('!projectOwner', projectOwner);
    console.log('!lowcaseOwner', lowcaseOwner);
  } catch (error) {
    console.error('Error in getProjctOwner:', error);
    throw error;
  }
};

export const createContract = async () => {
  const contractAddress = DEPLOYER_CONTRACT.polygon_amoy;
  try {
    const writeContract = await loadWriteContract_a(contractAddress);
    const transaction = await writeContract.createNewProject();
    const result = await transaction.wait();

    const signer = await getAddress();

    writeContract.on('ProjectCreated', (owner, project) => {
      console.log(
        `New project created by ${owner}. Project address: ${project}`
      );
    });

    const projectCONT = await writeContract.getProjectList();
    console.log(projectCONT);

    const projectList = Object.values(projectCONT); // lista på goFundMe-kontrakt
    const projects = [];
    for (const project of projectList) {
      const writeContract_b = await loadWriteContract_b(project); // läser goFundMe-kontrakt
      const projectOwnerBig = await writeContract_b.getOwner();
      const projectOwner = projectOwnerBig.toLowerCase();
      if (signer == projectOwner) {
        projects.push(project);
      }
    }

    const newestProject = projects.at(-1);
    const projectIndex = projects.length + 1;

    return { newestProject, projectIndex, signer };
  } catch (error) {
    console.error('Error in createApplicationContract:', error);
    throw error;
  }
};

export const loadWriteContract_a = async (contractAddress) => {
  if (!contractAddress) {
    throw new Error('Contract address is required');
  }

  console.log('provider', provider);

  const signer = await provider.getSigner();
  console.log('!signer', signer);

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi_a,
    signer
  );

  return applicationWriteContract;
};

export const loadWriteContract_b = async (contractAddress) => {
  if (!contractAddress) {
    throw new Error('Contract address is required');
  }

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi_b,
    window.provider
  );

  return applicationWriteContract;
};

export const fetchContractAddress = async () => {
  const contractAddress = DEPLOYER_CONTRACT.avax_fuji;
  try {
    const readContract = await loadWriteContract_a(contractAddress);
    return await readContract.ProjectCreated();
  } catch (error) {
    console.error('Error in fetching:', error);
    throw error;
  }
};

//fetch application

export const fetchApplicationContract = async () => {
  try {
    const contractAddress = 'from database?';
    const readContract = await loadReadContract(contractAddress);
    return await readContract.projectName();
  } catch (error) {
    console.error('Error in fetching:', error);
    throw error;
  }
};

export const loadReadContract = async (contractAddress) => {
  if (contractAddress === '') {
    return;
  }
  const applicationReadContract = new ethers.Contract(
    contractAddress,
    abi_a,
    window.provider
  );
  return applicationReadContract;
};

// Sender funding contract

export const funderSend = async (amount, index) => {
  try {
    const contractAddress = SENDER_CONTRACT.eth_sepholia;

    const writeContract = await loadWriteContract_c(contractAddress);

    const chainSelector = CHAIN_SELECTOR.polygon_amoy;
    const indexString = index.toString();
    const amountDecimal = amount * 1000000;

    const usdcTransfer = await writeContract.sendMessagePayLINK(
      chainSelector,
      indexString,
      amountDecimal
    );

    const response = await usdcTransfer.wait();

    return response;
  } catch (error) {
    console.log('funkade inte', error);
  }
};

export const loadWriteContract_c = async (contractAddress) => {
  console.log('!load start');

  console.log('provider', provider);

  const signer = await provider.getSigner();

  console.log('signer', signer);

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi_ccip_sender,
    signer
  );
  // console.log('!applicationWriteContract:', applicationWriteContract);

  return applicationWriteContract;
};

export const fetchFunding = async (address) => {
  try {
    const contractAddress = address;
    const readContract = await loadWriteContract_project(contractAddress);
    console.log(readContract);
    const response = await readContract.getTotalBalance();

    console.log(Number(response).toFixed(3));
  } catch (error) {
    console.error('Error in fetching:', error);
    throw error;
  }
};

export const loadWriteContract_project = async (contractAddress) => {
  if (contractAddress === '') {
    return;
  }

  const signer = await provider.getSigner();

  const applicationReadContract = new ethers.Contract(
    contractAddress,
    abi_b,
    signer
  );
  return applicationReadContract;
};

//create application

// export const createApplicationContract = async (contractInput) => {
//   try {
//     const { company, amount } = contractInput;

//     const parsedAmount = parseInt(amount);
//     console.log('!contract input', company, parsedAmount);

//     const functionInput = {
//       company,
//       parsedAmount,
//     };

//     const contractAddress = DEPLOYER_CONTRACT.avax_fuji;
//     const writeContract = await loadWriteContract_a(contractAddress);
//     console.log('!writeContract:', writeContract);

//     const transaction = await writeContract.createNewProject(
//       functionInput
//       // {
//       //   gasLimit: 300000,
//       // }
//     );
//     console.log('!transaction:', transaction);

//     const result = await transaction.wait();
//     console.log(result);
//     return result;
//   } catch (error) {
//     console.error('Error in createApplicationContract:', error);
//     throw error;
//   }
// };

// export const loadWriteContract_a = async (contractAddress) => {
//   if (!contractAddress) {
//     throw new Error('Contract address is required');
//   }
//   const signer = await provider.getSigner();
//   console.log('!signer', signer);

//   const applicationWriteContract = new ethers.Contract(
//     contractAddress,
//     abi_a,
//     signer
//   );
//   console.log('!applicationWriteContract:', applicationWriteContract);

//   return applicationWriteContract;
// };

// TRANSACTION INFO

// fetch hash info

// export const getTransactionDetails = async (hash) => {
//   try {
//     // Fetch transaction receipt
//     const receipt = await provider.getTransactionReceipt(hash);
//     console.log('Receipt:', receipt);
//     // Decode logs
//     const logs = receipt.logs;
//     console.log('logs', logs);

//     const eventInterface = new ethers.utils.Interface(abi_a);

//     logs.forEach((log) => {
//       try {
//         const decodedLog = eventInterface.parseLog(log);
//         if (decodedLog.name === 'ProjectCreated') {
//           console.log(
//             'New Contract Address:',
//             decodedLog.args.newProjectAddress
//           );
//         }
//       } catch (error) {
//         // Ignore log entries that can't be decoded
//       }
//     });
//   } catch (error) {
//     console.error('Error fetching transaction receipt and logs:', error);
//   }
// };
