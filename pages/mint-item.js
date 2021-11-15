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

    const router = userRouter()

    //set up a funtion to fireoff when we update files in our form - we can add our NFT images- IPFS
     async function onChange(e){
         const file = e.target.files[0]
         try{

         
         const  added= await client.add(
             file,{
                 progress:(prog) => console.log(`received: ${prog}`)
             }
         )
         const url = `https://ipfs.infura.io:5001/api/v0/${added.path}`
         setFileUrl(url)
            } catch (error){
                console.log('error uploading file:', error)
            }
     }
}

async function createMarket(){
    const {name, price, description} = formInput
    if(!name || !description || !price || !fileUrl) return
    //upload to IPFS
    const data = JSON.stringify({
        name, description, image: fileUrl
    })
    try{
           const  added= await client.add(data)
        const url = `https://ipfs.infura.io:5001/api/v0/${added.path}`
        //run a function that creates sale and passes in the url
        createSale(url)
           } catch (error){
               console.log('error uploading file:', error)
           }
}

async function createSale(url){
    //create the items and list them on the marketplace
    const web3Modal = new Web3Modal()
    const connection = await web3Modal.connect()
    const provider = new ethers.providers.Web3Provider(connection)
    const signer = provider.getSigner()
            //we want to create the token
    let contract = new ethers.Contract(nftaddress, NFT.abi, signer)
    let transaction = await contract.mintToken(url)
    let tx = await transaction.wait()
    let event = tx.events[0]
    let value = event.args[2]
    let tokenId = value.toNumber()
    const price = ethers.utils.parseUnits(formInput.price, 'ether')
    
    //list the item for sale on the marketplace
    contract = new ethers.Contract(nftMarketAddress, Oja.abi)
    let listingPrice = await contract.getListingPrice()
    listingPrice = listingPrice.toString()

    transaction = await contract.makeMarketItem(nftAddress, tokenId, price, {value: lisitingPrice})
}