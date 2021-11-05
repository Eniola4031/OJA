import '../styles/globals.css'
import './app.css'
import Link from 'next/link'


function ojaMarketplace({Component, pageProps}){
  return(
    <div>
      <nav className='border-b p-6' style={{backgroundColor:'skyblue'}}>
        <p className='text-4x1 font-bold text-black'> OJA AFRICAN NFT MARKETPLACE
        </p>
        <div className='flex mt-4 justify-center'>
          <Link href='/'>
            <a className='mr-6'> Home</a>
          </Link>
          <Link href='mint-item'>
            <a className='mr-6'> Mint Item</a>
          </Link>
           <Link href='/my-nfts'>
            <a className='mr-6'>My NFTs</a>
          </Link> 
          <Link href='/account-dashbaord'>
            <a className='mr-6'> Account Dashboard</a>
          </Link>
        </div>
      </nav>
      <Component {...pageProps} />
    </div>
    
  )
}

export default ojaMarketplace
