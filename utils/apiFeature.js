import { ethers } from "ethers";
import Web3Modal from 'web3modal';

import { ChatAppAddress,ChatAppABI } from "@/Context/constants";

export const CheckifWalletisconnected = async () => {
    try{
        if(!window.ethereum) return console.log("install metamask");

        const account = await window.ethereum.request({
            methods: "eth_accounts",
        })

        const firstAccount = account[0]

        return firstAccount;

    }catch(e){
        console.log("install metamask")
        return e;
    }
}


export const connectWallet = async () => {
    try{
        if(!window.ethereum) return console.log("install metamask");

        const account = await window.ethereum.request({
            methods: "eth_requestAccounts",
        })

        const firstAccount = account[0]

        return firstAccount;

    }catch(e){
        console.log("install metamask")
        return e;
    }
}


const fetchContract = (signerOrProvider) => new ethers.Contract(ChatAppABI,ChatAppAddress,signerOrProvider);


export const connectingWithContract = async () => {
    try{
        const web3modal = new Web3Modal();
        const connection = web3modal.connect();
        const provider = new ethers.providers.Web3Provider(connection);
        const signer = provider.getSigner();
        const contract = fetchContract(signer);
        return contract;

    }catch(e){
        console.log(e)
        return e;
    }
}


export const convertTime = (time) => {
    const newtime = new Date(time.toNumber())
    const realtime = newtime.getHours() + "/" + newtime.getMinutes() + "/" + newtime.getSeconds() + " Date:"+ newtime.getDate()+"/"+(newtime.getMonth()+1)+"/"+newtime.getFullYear();
    return realtime;
}