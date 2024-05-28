import { ethers } from 'ethers';
import { FUJI_CONTRACT_ADDRESS, abi_a, abi_b } from './config.js';

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

// APPLICATIONS FUNCTIONS

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
    abi_b,
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
  console.log('!applicationWriteContract:', applicationWriteContract);

  return applicationWriteContract;
};

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
