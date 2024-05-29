import { ethers } from 'ethers';
import {
  FUJI_CONTRACT_ADDRESS,
  POLYGONTESTNET_CONTRACT_ADDRESS,
  abi_a,
  abi_b,
} from './config.js';

// WALLET FUNCTIONS

export const requestAccount = async () => {
  try {
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
    const contactAddress = '0x8B70bEE8a47ff616366cbC41679f6e6aD5d190d6';
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
  try {
    const contractAddress = POLYGONTESTNET_CONTRACT_ADDRESS;
    const writeContract = await loadWriteContract_a(contractAddress);
    console.log('!writeContract:', writeContract);

    const transaction = await writeContract.createNewProject();
    console.log('!transaction:', transaction);

    const result = await transaction.wait();
    console.log(result);
    // const txDetails = await getTransactionDetails(result.hash);
    // console.log('!txDetails', txDetails);
    // const fetchedContract = await fetchContractAddress();
    // console.log(fetchedContract);

    // const contract = await writeContract.on('ProjectCreated', (owner, project));
    // console.log(contract);

    // Skapa en kontraktsinstans
    const signer = await getAddress();
    console.log('!signer', signer);
    // const contract = new ethers.Contract(contractAddress, abi_a, signer);

    // Lyssna på ProjectCreated-eventet
    writeContract.on('ProjectCreated', (owner, project) => {
      console.log(
        `New project created by ${owner}. Project address: ${project}`
      );
    });

    const projectCONT = await writeContract.getProjectList();
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
    console.log('!newestProject:', newestProject);

    return { newestProject, projectIndex, signer };
    //const projectCount = await loadReadContract(
    //FUJI_CONTRACT_ADDRESS,
    //).projectCount();
    //console.log("!projectCount:", projectCount);
    //let ownerPorjects = [];
    //for (i = 0; i < projectCount; i++) {
    //const project = await writeContract.projectList(i);
    //console.log("!project:", project);
    //const writeContract_b = await loadWriteContract_b(project);
    //const projectOwner = await writeContract_b.getOwner();
    //if (projectOwner == signer) {
    //ownerPorjects.push(project);
    //}
    //}
    //console.log("!ownerProjects:", ownerPorjects);
    //const newestProject = ownerPorjects.at(-1);
    //console.log("!newestProject:", newestProject);
  } catch (error) {
    console.error('Error in createApplicationContract:', error);
    throw error;
  }
};

export const loadWriteContract_a = async (contractAddress) => {
  if (!contractAddress) {
    throw new Error('Contract address is required');
  }
  const signer = await provider.getSigner();
  console.log('!signer', signer);

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi_a,
    signer
  );
  // console.log('!applicationWriteContract:', applicationWriteContract);

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
  // console.log('!applicationWriteContract:', applicationWriteContract);

  return applicationWriteContract;
};

export const fetchContractAddress = async () => {
  const contractAddress = FUJI_CONTRACT_ADDRESS;
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

//create application

export const createApplicationContract = async (contractInput) => {
  try {
    const { company, amount } = contractInput;

    const parsedAmount = parseInt(amount);
    console.log('!contract input', company, parsedAmount);

    const functionInput = {
      company,
      parsedAmount,
    };

    const contractAddress = FUJI_CONTRACT_ADDRESS;
    const writeContract = await loadWriteContract_a(contractAddress);
    console.log('!writeContract:', writeContract);

    const transaction = await writeContract.createNewProject(
      functionInput
      // {
      //   gasLimit: 300000,
      // }
    );
    console.log('!transaction:', transaction);

    const result = await transaction.wait();
    console.log(result);
    return result;
  } catch (error) {
    console.error('Error in createApplicationContract:', error);
    throw error;
  }
};

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

export const getTransactionDetails = async (hash) => {
  try {
    // Fetch transaction receipt
    const receipt = await provider.getTransactionReceipt(hash);
    console.log('Receipt:', receipt);
    // Decode logs
    const logs = receipt.logs;
    console.log('logs', logs);

    const eventInterface = new ethers.utils.Interface(abi_a);

    logs.forEach((log) => {
      try {
        const decodedLog = eventInterface.parseLog(log);
        if (decodedLog.name === 'ProjectCreated') {
          console.log(
            'New Contract Address:',
            decodedLog.args.newProjectAddress
          );
        }
      } catch (error) {
        // Ignore log entries that can't be decoded
      }
    });
  } catch (error) {
    console.error('Error fetching transaction receipt and logs:', error);
  }
};
