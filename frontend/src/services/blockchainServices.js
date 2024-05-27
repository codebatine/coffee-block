import { ethers } from 'ethers';
import { abi } from '../services/config.js';
import { CONTRTACT_ADDRESS } from '../services/config.js';

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
    abi,
    window.provider
  );

  return applicationReadContract;
};

export const loadWriteContract = async (contractAddress) => {
  if (contractAddress === '') {
    return;
  }
  const signer = await provider.getSigner();

  const applicationWriteContract = new ethers.Contract(
    contractAddress,
    abi,
    signer
  );
  console.log('load contract', applicationWriteContract);

  return applicationWriteContract;
};

export const fetchApplicationContract = async () => {
  try {
    const contractAddress = CONTRTACT_ADDRESS;
    const readContract = await loadReadContract(contractAddress);
    return await readContract.projectName();
  } catch (error) {
    console.error('Error in fetching:', error);
    throw error;
  }
};

export const createApplicationContract = async (contractInput) => {
  // try {
  //   const { company, amount, deadline } = contractInput;
  //   const contractAddress = CONTRTACT_ADDRESS;
  //   const writeContract = await loadWriteContract(contractAddress);
  //   const transaction = await writeContract.fund(company, amount, deadline);
  //   const result = await transaction.wait();
  //   console.log(result);
  //   transaction;
  // } catch (error) {
  //   console.error('Error in createApplicationContract:', error);
  //   throw error;
  // }
};
