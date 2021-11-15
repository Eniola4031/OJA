import {ethers} from 'ethers'
import {useState} from 'react'
import web3Modal from 'web3Modal'
import {create as ipfsHttpClient} from 'ipfs-http-client'
import{nftAddress, nftMarketAddress} from '../config'
// in this component, we set the ipfs up to host out nft data of file storage
import NFT from '../artifacts/contracts/NFT.sol/NFT.json'
import Oja from '../artifacts/contracts/oja.sol/oja.json'

const client= ipfsHttpClient('https://ipfs.infura.io:5001/api/v0',)

export  default function mintItem(){
    const[fileUrl, setFileUrl]= useState(null)
    const [formInput, updateFormInput] = useState({price:'', name:'', description:''})
}