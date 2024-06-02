import ABI_A from '../../../contract/out/ControllerGoFundMe.sol/ControllerGoFundMe.json';
import ABI_B from '../../../contract/out/UsdcGoFundMe.sol/GoFundMe.json';
import ABI_C from '../../../contract/out/Sender.sol/Sender.json';
import ABI_D from '../../../contract/out/Reciever.sol/Receiver.json';
import ABI_E from '../../../contract/out/BalanceOf.sol/BalanceOfContractUsdc.json';

export const DEPLOYER_CONTRACT = {
  eth_sepholia: '0x42FA73D453A0413902F1bCbE87B8E5F7d835C768',
  avax_fuji: '0x7cAc2A6e95e04F41D54418A1E2b0E4B79F7E9b83',
  polygon: '0x2E90dEA7F1501b174B0a3Ea0E2A7B94471493547',
  polygon_amoy: '0x5CE160AF3039E5Ac7111759aca1AECF8b46Fa6AD',
};

export const RECIEVER_CONTRACT = {
  eth_sepholia: '0x38752CfEf603E6E0080E6ac5Cd149b8E91fF0Fd3',
  polygon_amoy: '0x9323388ACA8C0c4E2084973Bab586b1D0Bb34a36',
};

export const SENDER_CONTRACT = {
  polygon_amoy: '0x2D205984F019e00405d2fb8719cadfdB7B7D965b',
  eth_sepholia: '0x3A738a2c350Cdea50407eBD2B0BA8359583a76cD',
};

export const CHAIN_SELECTOR = {
  eth_sepolia: '16015286601757825753',
  polygon_amoy: '16281711391670634445',
};

export const abi_a = ABI_A.abi;
export const abi_b = ABI_B.abi;
export const abi_e = ABI_E.abi;
export const abi_ccip_sender = ABI_C.abi;
export const abi_ccip_receiver = ABI_D.abi;
