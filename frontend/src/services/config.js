import ABI_A from '../../../contract/out/ControllerGoFundMe.sol/ControllerGoFundMe.json';
import ABI_B from '../../../contract/out/UsdcGoFundMe.sol/GoFundMe.json';
import ABI_C from '../../../CCIP/out/Sender.sol/Sender.json';
import ABI_D from '../../../CCIP/out/Reciever.sol/Receiver.json';

export const DEPLOYER_CONTRACT = {
  eth_sepholia: '0x42FA73D453A0413902F1bCbE87B8E5F7d835C768',
  avax_fuji: '0x7cAc2A6e95e04F41D54418A1E2b0E4B79F7E9b83',
  polygon: '0x2E90dEA7F1501b174B0a3Ea0E2A7B94471493547',
  polygon_amoy: '0xa7E124c5572c12507d2EAd49C923974bdfB21824',
};

export const RECIEVER_CONTRACT = {
  eth_sepholia: '0x38752CfEf603E6E0080E6ac5Cd149b8E91fF0Fd3',
  polygon_amoy: '0x0C3a9B3DC964c3ec8c378abE0b42EF3426A06cEB',
};

export const SENDER_CONTRACT = {
  polygon_amoy: '0x2D205984F019e00405d2fb8719cadfdB7B7D965b',
  eth_sepholia: '0x679806D95C0F39604faA3823a6D017512a17054d',
};

export const CHAIN_SELECTOR = {
  eth_sepolia: '16015286601757825753',
  polygon_amoy: '16281711391670634445',
};

export const abi_a = ABI_A.abi;
export const abi_b = ABI_B.abi;
export const abi_ccip_sender = ABI_C.abi;
export const abi_ccip_receiver = ABI_D.abi;
