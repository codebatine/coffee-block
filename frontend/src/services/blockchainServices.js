import { ethers } from 'ethers';
import { CONTRTACT_ADDRESS_A, abi_a } from './config.js';

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
  console.log('WalletChecker');

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

// export const fetchApplicationContract = async () => {
//   try {
//     const contractAddress = CONTRTACT_ADDRESS_A;
//     const readContract = await loadReadContract(contractAddress);
//     return await readContract.projectName();
//   } catch (error) {
//     console.error('Error in fetching:', error);
//     throw error;
//   }
// };

export const createApplicationContract = async (contractInput) => {
  try {
    const { company, amount } = contractInput;

    const parsedAmount = parseInt(amount);
    console.log('!contract input', company, parsedAmount);

    const contractAddress = CONTRTACT_ADDRESS_A;
    const writeContract = await loadWriteContract_a(contractAddress);
    console.log('!writeContract:', writeContract);

    const transaction = await writeContract.createNewProject(
      parsedAmount,
      company
      // {
      //   gasLimit: 300000,
      // }
    );
    console.log('!transaction:', transaction);

    const result = await transaction.wait();
    console.log(result);
  } catch (error) {
    console.error('Error in createApplicationContract:', error);
    throw error;
  }
};

export const loadWriteContract_a = async (contractAddress) => {
  if (contractAddress === '') {
    return;
  }
  const signer = await provider.getSigner();
  console.log('!signer', signer);

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi_a,
    signer
  );
  // console.log('load contract', applicationWriteContract);

  return applicationWriteContract;
};
